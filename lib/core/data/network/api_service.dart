import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../features/authentication/data/models/auth_result_model.dart';
import '../../../features/authentication/data/models/otp_verification_model.dart';
import '../../../features/authentication/data/models/password_update_model.dart';
import '../../../features/authentication/data/models/role_selection_model.dart';
import '../../../features/shared/data/models/attendance_request_model.dart';
import '../../../features/shared/data/models/communication_inbox_model.dart';
import '../../../features/shared/data/models/timetable_model.dart';
import '../../../features/shared/data/models/users_list_response_model.dart';
import '../../../features/shared/data/models/yearplan_model.dart';
import '../../../features/user_roles/coordinator/data/models/coordinator_timetable_model.dart';
import '../../../features/user_roles/coordinator/data/models/substitution_model.dart';
import '../../../features/user_roles/teacher/data/models/portion_plan_model.dart';
import '../../constants/api_constants.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: ApiConstants.baseUrl + ApiConstants.apiVersion)
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl}) = _ApiService;

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

  // ==================== ADMIN ENDPOINTS ====================
  // Role: Admin
  @GET(ApiConstants.adminUsers)
  Future<UsersListResponseModel> getAdminUsers(@Query('userId') String userId);

  // ==================== COORDINATOR ENDPOINTS ====================
  // Role: Coordinator
  @GET(ApiConstants.coordinatorTimetable)
  Future<CoordinatorTimetableModel> getCoordinatorTimetable();

  @POST(ApiConstants.coordinatorSubstitution)
  Future<SubstitutionModel> createSubstitution(
    @Body() CreateSubstitutionModel substitutionData,
  );

  // ==================== TEACHER ENDPOINTS ====================
  // Role: Teacher
  @GET(ApiConstants.teacherPortionPlan)
  Future<PortionPlanResponseModel> getTeacherPortionPlans();

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

  // ==================== ATTENDANCE ENDPOINTS ====================
  // Teacher: Create leave request
  @POST(ApiConstants.attendanceRequest)
  Future<AttendanceRequestModel> createAttendanceRequest(
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

  // ==================== COMMUNICATION ENDPOINTS ====================
  // Get all communication inbox (leave requests, mails, requests etc)
  @GET(ApiConstants.communicationInbox)
  Future<CommunicationInboxModel> getCommunicationInbox();
}
