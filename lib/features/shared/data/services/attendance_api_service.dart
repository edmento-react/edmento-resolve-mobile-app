import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/api_constants.dart';
import '../models/attendance_request_model.dart';

part 'attendance_api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class AttendanceApiService {
  factory AttendanceApiService(Dio dio, {String baseUrl}) =
      _AttendanceApiService;

  // ==================== ATTENDANCE ENDPOINTS ====================
  // Teacher: Create leave request
  @POST(ApiConstants.attendanceRequest)
  Future<AttendanceRequestModel> createRequest(
    @Body() CreateAttendanceRequestModel requestData,
  );

  // Coordinator: Coordinator approval for leave
  @POST(ApiConstants.attendanceCoordinatorApproval)
  Future<AttendanceRequestModel> coordinatorApproval(
    @Body() AttendanceApprovalModel approvalData,
  );

  // Principal: Principal approval for leave
  @POST(ApiConstants.attendancePrincipalApproval)
  Future<AttendanceRequestModel> principalApproval(
    @Body() AttendanceApprovalModel approvalData,
  );
}
