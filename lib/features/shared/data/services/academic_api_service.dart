import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../models/timetable_model.dart';
import '../models/yearplan_model.dart';

part 'academic_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class AcademicApiService {
  factory AcademicApiService(Dio dio, {String baseUrl}) = _AcademicApiService;

  // ==================== ACADEMIC ENDPOINTS ====================
  // Any authenticated user
  @GET('${ApiConstants.timetableByDivision}/{divisionId}')
  Future<TimetableResponseModel> getTimetableByDivision(
    @Path('divisionId') String divisionId,
  );

  @GET('${ApiConstants.yearPlanByClass}/{classId}')
  Future<YearPlanResponseModel> getYearPlanByClass(
    @Path('classId') String classId,
  );
}
