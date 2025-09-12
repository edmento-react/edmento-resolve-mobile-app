import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../models/coordinator_timetable_model.dart';
import '../models/substitution_model.dart';

part 'coordinator_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class CoordinatorApiService {
  factory CoordinatorApiService(Dio dio, {String baseUrl}) =
      _CoordinatorApiService;

  // ==================== COORDINATOR ENDPOINTS ====================
  // Role: Coordinator
  @GET(ApiConstants.coordinatorTimetable)
  Future<CoordinatorTimetableModel> getTimetable();

  @POST(ApiConstants.coordinatorSubstitution)
  Future<SubstitutionModel> createSubstitution(
    @Body() CreateSubstitutionModel substitutionData,
  );
}
