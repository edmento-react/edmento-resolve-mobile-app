// import 'package:dio/dio.dart';
// import 'package:edmentoresolve/core/constants/api_constants.dart';
// import 'package:edmentoresolve/features/authentication/data/models/auth_result_model.dart';
// import 'package:retrofit/retrofit.dart';

// part 'auth_api_service.g.dart';

// @RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
// abstract class AuthApiService {
//   factory AuthApiService(Dio dio) = _AuthApiService;

//   @POST(ApiConstants.login)
//   Future<HttpResponse<AuthResultModel>> login({
//     @Query('email') required String email,
//     @Query('password') required String password,
//   });

//   @POST(ApiConstants.logout)
//   Future<HttpResponse<void>> logout({
//     @Query('sessionId') required String session,
//   });

//   @POST(ApiConstants.forgotPassword)
//   Future<HttpResponse<bool>> sendForgotPasswordOtp({
//     @Query('email') required String email,
//   });

//   @POST(ApiConstants.verifyOtp)
//   Future<HttpResponse<bool>> verifyOtp({
//     @Query('email') required String email,
//     @Query('otp') required String otp,
//   });

//   @POST(ApiConstants.resetPassword)
//   Future<HttpResponse<bool>> resetPassword({
//     @Query('email') required String email,
//     @Query('new_password') required String newPassword,
//   });
// }
