import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../core/constants/api_constants.dart';
import '../models/auth_result_model.dart';
import '../models/otp_verification_model.dart';
import '../models/password_update_model.dart';
import '../models/role_selection_model.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  // ==================== AUTHENTICATION ENDPOINTS ====================
  // Public – No role restrictions
  @POST(ApiConstants.login)
  Future<AuthResultModel> login(@Body() Map<String, dynamic> credentials);

  @POST(ApiConstants.logout)
  Future<void> logout();

  @POST(ApiConstants.verifyOtp)
  Future<OtpVerificationResponseModel> verifyOtp(
    @Body() OtpVerificationModel otpData,
  );

  @POST(ApiConstants.updatePassword)
  Future<PasswordResponseModel> updatePassword(
    @Body() PasswordUpdateModel passwordData,
  );

  @POST(ApiConstants.forgotPassword)
  Future<PasswordResponseModel> sendForgotPasswordOtp(
    @Body() ForgotPasswordModel emailData,
  );

  @POST(ApiConstants.resetPassword)
  Future<PasswordResponseModel> resetPassword(
    @Body() ResetPasswordModel resetData,
  );

  @POST(ApiConstants.selectRole)
  Future<RoleSelectionResponseModel> selectRole(
    @Body() RoleSelectionModel roleData,
  );

  @GET(ApiConstants.getPositions)
  Future<List<PositionModel>> getPositions();

  @GET(ApiConstants.getUserRoles)
  Future<List<UserRoleModel>> getUserRoles();
}
