import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/authentication/data/models/auth_result_model.dart';
import '../../../features/authentication/data/models/user_model.dart';
import '../../constants/api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

  // Authentication endpoints
  @POST(ApiConstants.login)
  Future<AuthResultModel> login(@Body() Map<String, dynamic> credentials);

  @POST(ApiConstants.refreshToken)
  Future<AuthResultModel> refreshToken(
    @Body() Map<String, dynamic> refreshData,
  );

  // User endpoints
  @GET(ApiConstants.userProfile)
  Future<UserModel> getCurrentUser();

  @PUT(ApiConstants.updateProfile)
  Future<UserModel> updateProfile(@Body() Map<String, dynamic> profileData);
}
