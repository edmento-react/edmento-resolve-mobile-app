// import 'dart:convert';

// import 'package:edmentoresolve/core/constants/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// import '../../../../core/constants/app_constants.dart';
// import '../models/auth_result_model.dart';
// import '../models/user_model.dart';
// import 'auth_local_data_source.dart';

// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   final SharedPreferences sharedPreferences;

//   AuthLocalDataSourceImpl(this.sharedPreferences);

//   @override
//   Future<void> cacheAuthResult(AuthResultModel authResult) async {
//     print(
//       'AuthLocalDataSourceImpl: Caching auth result = ${authResult.toJson()}',
//     );
//     await sharedPreferences.setString(
//       'auth_result',
//       jsonEncode(authResult.toJson()),
//     );
//     await cacheToken(authResult.token);
//     await cacheUser(authResult.user);
//   }

//   @override
//   Future<AuthResultModel?> getCachedAuthResult() async {
//     final jsonString = sharedPreferences.getString('auth_result');
//     if (jsonString != null) {
//       try {
//         final json = jsonDecode(jsonString);
//         return AuthResultModel.fromJson(json);
//       } catch (e) {
//         return null;
//       }
//     }
//     return null;
//   }

//   @override
//   Future<void> clearCache() async {
//     await sharedPreferences.remove('auth_result');
//     await sharedPreferences.remove(AppConstants.tokenKey);
//     await sharedPreferences.remove(AppConstants.userKey);
//   }

//   @override
//   Future<void> cacheToken(String token) async {
//     await sharedPreferences.setString(AppConstants.tokenKey, token);
//   }

//   @override
//   Future<String?> getCachedToken() async {
//     return sharedPreferences.getString(AppConstants.tokenKey);
//   }

//   @override
//   Future<void> cacheUser(UserModel user) async {
//     print('============================user key============================');
//     await sharedPreferences.setString(
//       AppConstants.userKey,
//       jsonEncode(user.toJson()),
//     );
//     final sharedPrefsService = await SharedPrefsService.getInstance();

//     await sharedPrefsService.cacheUser(user.toJson());
//   }

//   @override
//   Future<UserModel?> getCachedUser() async {
//     final jsonString = sharedPreferences.getString(AppConstants.userKey);
//     print('cached user ==================================> $jsonString');
//     if (jsonString != null) {
//       try {
//         print('in try----------------------------------------');
//         final json = jsonDecode(jsonString);
//         return UserModel.fromJson(json);
//       } catch (e) {
//         print('in catch----$e------------------------------------');

//         return null;
//       }
//     }
//     return null;
//   }
// }
