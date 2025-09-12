import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../models/portion_plan_model.dart';

part 'teacher_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class TeacherApiService {
  factory TeacherApiService(Dio dio, {String baseUrl}) = _TeacherApiService;

  // ==================== TEACHER ENDPOINTS ====================
  // Role: Teacher
  @GET(ApiConstants.teacherPortionPlan)
  Future<PortionPlanResponseModel> getPortionPlans();
}
