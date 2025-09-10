import 'dart:async';

import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

import '../../constants/api_constants.dart';
import '../../error/exceptions.dart';
import '../storage/storage_util.dart'; // <- one facade (secure+prefs)
import 'network_info.dart';

class ApiClient {
  ApiClient(this._storage, this._networkInfo)
    : _dio = Dio(
        BaseOptions(
          baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion,
          connectTimeout: const Duration(milliseconds: 15000),
          receiveTimeout: const Duration(milliseconds: 15000),
          sendTimeout: const Duration(milliseconds: 15000),
          headers: {
            'Accept': 'application/json',
            'Content-Type': ApiConstants.contentType,
            'Accept-Encoding': 'gzip, deflate',
          },
        ),
      ) {
    _setupInterceptors();
  }

  final Dio _dio;
  final Logger _logger = Logger();
  final StorageService _storage;
  final NetworkInfo _networkInfo;

  Dio get dio => _dio;

  /// Call once after DI to preload token header if any.
  Future<void> initializeAuthHeaders() async {
    try {
      final token = await _storage.getAuthToken();
      if (token != null && token.isNotEmpty) {
        _dio.options.headers[ApiConstants.authorization] =
            '${ApiConstants.bearer} $token';
      }
    } catch (e) {
      _logger.e('initializeAuthHeaders error: $e');
    }
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // 1) Connectivity gate
          final connected = await _networkInfo.isConnected;
          if (!connected) {
            return handler.reject(
              DioException(
                requestOptions: options,
                type: DioExceptionType.connectionError,
                error: 'No internet connection',
              ),
            );
          }

          // 2) Attach latest token if exists
          try {
            final token = await _storage.getAuthToken();
            if (token != null && token.isNotEmpty) {
              options.headers[ApiConstants.authorization] =
                  '${ApiConstants.bearer} $token';
            }
          } catch (e) {
            // keep going; request can still proceed without auth
            assert(() {
              _logger.w('Auth token read failed: $e');
              return true;
            }());
          }

          // 3) Attach selected role (non-sensitive) if exists
          try {
            final roleId = _storage.getUserRoleId(); // sync getter
            if (roleId != null) {
              options.headers['X-Role-Id'] = roleId.toString();
            }
          } catch (e) {
            assert(() {
              _logger.w('Role header set failed: $e');
              return true;
            }());
          }

          // 4) Debug logs
          assert(() {
            _logger.i('REQUEST[${options.method}] => ${options.uri}');
            return true;
          }());

          handler.next(options);
        },
        onResponse: (response, handler) {
          assert(() {
            _logger.i(
              'RESPONSE[${response.statusCode}] => ${response.requestOptions.uri}',
            );
            return true;
          }());
          handler.next(response);
        },
        onError: (error, handler) async {
          // Debug log
          assert(() {
            _logger.e(
              'ERROR[${error.response?.statusCode}] => ${error.requestOptions.uri} || ${error.message}',
            );
            return true;
          }());

          // Attempt refresh on 401 once
          // if (_shouldAttemptRefresh(error)) {
          //   try {
          //     final refreshed = await _refreshToken();
          //     if (refreshed) {
          //       final clone = await _retry(error.requestOptions);
          //       return handler.resolve(clone);
          //     }
          //   } catch (e) {
          //     assert(() {
          //       _logger.e('Token refresh failed: $e');
          //       return true;
          //     }());
          //     // fall through to normal mapping below
          //   }
          // }

          handler.next(error);
        },
      ),
    );
  }

  // bool _shouldAttemptRefresh(DioException error) {
  //   if (error.type != DioExceptionType.badResponse) return false;
  //   final status = error.response?.statusCode ?? 0;
  //   final alreadyRetried =
  //       error.requestOptions.extra['__retry_attempted__'] == true;
  //   return status == 401 && !alreadyRetried;
  // }

  // Future<bool> _refreshToken() async {
  //   final refreshToken = await _storage.getRefreshToken();
  //   if (refreshToken == null || refreshToken.isEmpty) return false;

  //   try {
  //     // Adjust endpoint/payload to your backend contract.
  //     final resp = await _dio.post(
  //       ApiConstants.refreshTokenPath, // e.g. '/auth/refresh'
  //       data: {'refresh_token': refreshToken},
  //       options: Options(
  //         headers: {
  //           // Do NOT send stale Bearer on refresh if your backend forbids it
  //           ApiConstants.authorization: null,
  //           'Content-Type': 'application/json',
  //         },
  //       ),
  //     );

  //     final newToken = resp.data?['access_token'] as String?;
  //     final newRefresh = resp.data?['refresh_token'] as String?;
  //     if (newToken == null || newToken.isEmpty) return false;

  //     await _storage.setAuthToken(newToken);
  //     if (newRefresh != null && newRefresh.isNotEmpty) {
  //       await _storage.setRefreshToken(newRefresh);
  //     }

  //     _dio.options.headers[ApiConstants.authorization] =
  //         '${ApiConstants.bearer} $newToken';
  //     return true;
  //   } on DioException catch (e) {
  //     assert(() {
  //       _logger.e('Refresh request failed: ${e.message}');
  //       return true;
  //     }());
  //     return false;
  //   } catch (e) {
  //     return false;
  //   }
  // }

  // Future<Response<dynamic>> _retry(RequestOptions request) async {
  //   final opts = Options(
  //     method: request.method,
  //     headers: Map<String, dynamic>.from(request.headers),
  //     responseType: request.responseType,
  //     contentType: request.contentType,
  //     followRedirects: request.followRedirects,
  //     validateStatus: request.validateStatus,
  //     receiveDataWhenStatusError: request.receiveDataWhenStatusError,
  //     listFormat: request.listFormat,
  //     requestEncoder: request.requestEncoder,
  //     responseDecoder: request.responseDecoder,
  //   );

  //   // mark retried
  //   request.extra['__retry_attempted__'] = true;

  //   return _dio.request<dynamic>(
  //     request.path,
  //     data: request.data,
  //     queryParameters: request.queryParameters,
  //     options: opts,
  //     cancelToken: request.cancelToken,
  //     onSendProgress: request.onSendProgress,
  //     onReceiveProgress: request.onReceiveProgress,
  //   );
  // }

  // Convenience wrappers (optional but nice for DI/mocking)

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapDioToFailure(e);
    } catch (_) {
      throw const UnknownFailure('An unknown error occurred');
    }
  }

  Future<Response> post(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _mapDioToFailure(e);
    } catch (_) {
      throw const UnknownFailure('An unknown error occurred');
    }
  }

  Future<Response> put(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.put(path, data: data, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapDioToFailure(e);
    } catch (_) {
      throw const UnknownFailure('An unknown error occurred');
    }
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? data,
  }) async {
    try {
      return await _dio.delete(
        path,
        queryParameters: queryParameters,
        data: data,
      );
    } on DioException catch (e) {
      throw _mapDioToFailure(e);
    } catch (_) {
      throw const UnknownFailure('An unknown error occurred');
    }
  }

  Failure _mapDioToFailure(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure('Connection timeout');
      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final msg = _serverMessage(error) ?? 'Server error';
        switch (statusCode) {
          case 401:
            return const AuthenticationFailure(
              'Incorrect password. Please try again.',
            );
          case 403:
            return const AuthenticationFailure(
              'Access denied. You don\'t have permission.',
            );
          case 404:
            return const ServerFailure(
              'Email not recognized. Please check and try again.',
            );
          case 429:
            return const ServerFailure('Too many requests. Try later.');
          case 500:
          case 502:
          case 503:
          case 504:
            return const ServerFailure('Something went wrong. Try later.');
          default:
            return ServerFailure(msg);
        }
      case DioExceptionType.cancel:
        return const NetworkFailure('Request cancelled');
      case DioExceptionType.connectionError:
        return const NetworkFailure('No internet connection');
      default:
        return const NetworkFailure('Network error occurred');
    }
  }

  String? _serverMessage(DioException e) {
    final data = e.response?.data;
    if (data is Map && data['message'] is String)
      return data['message'] as String;
    if (data is String && data.isNotEmpty) return data;
    return null;
  }

  // Explicit API to set/remove token (useful right after login/logout)

  Future<void> setAuthToken(String token) async {
    await _storage.setAuthToken(token);
    _dio.options.headers[ApiConstants.authorization] =
        '${ApiConstants.bearer} $token';
  }

  Future<void> removeAuthToken() async {
    await _storage.clearAllPrefs();
    await _storage.clearAllPrefs();
    _dio.options.headers.remove(ApiConstants.authorization);
  }
}
