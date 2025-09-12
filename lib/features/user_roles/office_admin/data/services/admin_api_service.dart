import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../models/admin_user_model.dart';

part 'admin_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class AdminApiService {
  factory AdminApiService(Dio dio, {String baseUrl}) = _AdminApiService;

  // ==================== ADMIN ENDPOINTS ====================
  // Role: Admin
  @GET(ApiConstants.adminUsers)
  Future<AdminUsersResponseModel> getUsers();
}
