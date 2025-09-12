import 'package:dio/dio.dart';

import '../../../features/authentication/data/services/auth_api_service.dart';
import '../../../features/shared/data/services/academic_api_service.dart';
import '../../../features/shared/data/services/attendance_api_service.dart';
import '../../../features/shared/data/services/communication_api_service.dart';
import '../../../features/user_roles/coordinator/data/services/coordinator_api_service.dart';
import '../../../features/user_roles/office_admin/data/services/admin_api_service.dart';
import '../../../features/user_roles/teacher/data/services/teacher_api_service.dart';
import '../../constants/api_constants.dart';
import 'api_client.dart';
import 'api_service.dart';

/// Factory class for creating API services
/// Provides centralized access to all API services with proper dependency injection
class ApiClientFactory {
  final ApiClient _apiClient;

  ApiClientFactory(this._apiClient);

  /// Get the base API client
  ApiClient get apiClient => _apiClient;

  /// Get the main API service with all endpoints
  ApiService get mainApiService => ApiService(_apiClient.dio);

  // ==================== ROLE-SPECIFIC SERVICES ====================

  /// Get authentication API service
  AuthApiService get authApiService => AuthApiService(_apiClient.dio);

  /// Get admin API service
  AdminApiService get adminApiService => AdminApiService(_apiClient.dio);

  /// Get coordinator API service
  CoordinatorApiService get coordinatorApiService =>
      CoordinatorApiService(_apiClient.dio);

  /// Get teacher API service
  TeacherApiService get teacherApiService => TeacherApiService(_apiClient.dio);

  /// Get academic API service (available to all authenticated users)
  AcademicApiService get academicApiService =>
      AcademicApiService(_apiClient.dio);

  /// Get attendance API service
  AttendanceApiService get attendanceApiService =>
      AttendanceApiService(_apiClient.dio);

  /// Get communication API service
  CommunicationApiService get communicationApiService =>
      CommunicationApiService(_apiClient.dio);

  // ==================== UTILITY METHODS ====================

  /// Create a new API client factory with custom Dio instance
  factory ApiClientFactory.withDio(Dio dio) {
    // Create a mock storage and network info for the custom Dio
    // In a real implementation, you would inject these dependencies
    throw UnimplementedError('Custom Dio factory not implemented yet');
  }

  /// Get API service based on user role
  /// This method can be used to get the appropriate service based on user's current role
  T getServiceByRole<T>() {
    // This is a placeholder - in a real implementation, you would check the user's role
    // and return the appropriate service. For now, we return the main API service.
    return mainApiService as T;
  }

  /// Check if a specific endpoint requires authentication
  bool requiresAuthentication(String endpoint) {
    // All endpoints except login, logout, and OTP verification require authentication
    final publicEndpoints = [
      ApiConstants.login,
      ApiConstants.logout,
      ApiConstants.verifyOtp,
      ApiConstants.forgotPassword,
      ApiConstants.resetPassword,
    ];

    return !publicEndpoints.any((endpoint) => endpoint.contains(endpoint));
  }

  /// Get base URL for API calls
  String get baseUrl => ApiConstants.baseUrl + ApiConstants.apiVersion;
}
