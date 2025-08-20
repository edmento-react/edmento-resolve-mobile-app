class ApiConstants {
  // Base URLs
  static const String baseUrl =
      'https://edmento-school-management-production.up.railway.app';
  // static const String baseUrl = 'https://login-page-tz35.onrender.com';
  // static const String apiVersion = '/v1';
  static const String apiVersion = '/api';
  static const String schoolId =
      '785246956827'; //change this school id for every schools

  // Authentication Endpoints
  static const String login = '/auth/login';
  static const String forgotPassword = '/auth/forgot-password/send-otp';
  static const String verifyOtp = '/auth/verify-otp';
  static const String resetPassword = '/auth/forgot-password/reset';
  static const String selectRole = '/auth/select-role';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';

  // User Endpoints
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  static const String createUSer = '/admins/admin/create-user';

  // Common Headers
  static const String contentType = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}
