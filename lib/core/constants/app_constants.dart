class AppConstants {
  // static const String appName = 'Edmento Resolve';
  static const String appName = 'MES Central School';
  static const String appVersion = '1.0.0';

  // Shared Preferences Keys
  static const String sessionIdKey = 'auth_session_id';
  static const String userKey = 'user_data';
  static const String themeKey = 'theme_mode';

  // Error Messages
  static const String networkErrorMessage = 'No internet connection';
  static const String serverErrorMessage = 'Server error occurred';
  static const String unknownErrorMessage = 'Something went wrong';
}

// Role Constants
class UserRoles {
  static const int principal = 3;
  static const int vicePrincipal = 4;
  static const int coordinator = 5;
  static const int teacher = 6;
  static const int officeAdmin = 7;
  static const int student = 8;
  static const int parent = 9;

  static String getRoleName(int roleId) {
    switch (roleId) {
      case principal:
        return 'Principal';
      case vicePrincipal:
        return 'Vice Principal';
      case coordinator:
        return 'Coordinator';
      case teacher:
        return 'Teacher';
      case officeAdmin:
        return 'Office Admin';
      case parent:
        return 'Parent';
      case student:
        return 'Student';
      default:
        return 'Unknown';
    }
  }
}
