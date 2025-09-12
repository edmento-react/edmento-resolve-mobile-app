class ApiConstants {
  // ------------------ 🌍 Base URLs ------------------
  static const String baseUrl =
      'https://edmento-school-management-production.up.railway.app';
  static const String apiVersion = '/api/v1';

  // Change this school id per school (multi-tenant support)
  static const String schoolId = '785246956827';

  // ------------------ 🔐 Authentication Routes (/api/v1/auth) ------------------
  // Public – No role restrictions
  static const String login = '/auth/login';
  static const String logout = '/auth/logout';
  static const String verifyOtp = '/auth/verify-otp';
  static const String updatePassword = '/auth/update-password';
  static const String forgotPassword = '/auth/forgot-password/send-otp';
  static const String resetPassword = '/auth/forgot-password/reset';
  //   static const String forgotPasswordSendOtp = '/auth/forgot-password/send-otp';
  // static const String forgotPasswordReset = '/auth/forgot-password/reset';
  static const String selectRole = '/auth/select-role';
  static const String getPositions = '/auth/positions';
  static const String getUserRoles = '/auth/me/roles';
  static const String refreshToken = '/auth/refresh';

  // ------------------ 👤 User ------------------
  static const String userProfile = '/user/profile';
  static const String updateProfile = '/user/profile/update';

  // ------------------ 👨‍🏫 Admin Routes (/api/v1/admins) ------------------
  // Role: Admin
  static const String adminUsers = '/admins/users';

  // ------------------ 👨‍🏫 Coordinator Routes (/api/v1/coordinators) ------------------
  // Role: Coordinator
  static const String coordinatorTimetable = '/coordinators/timetable';
  static const String coordinatorSubstitution = '/coordinators/substitution';

  // ------------------ 👨‍🏫 Teacher Routes (/api/v1/teachers) ------------------
  // Role: Teacher
  static const String teacherPortionPlan = '/teachers/portion-plan';

  // ------------------ 👨‍🎓 Student Routes (/api/v1/students) ------------------
  // Role: Student
  // No routes currently defined, will be there!
  static const String studentBase = '/students';

  // ------------------ 👨‍👩‍👦 Parent Routes (/api/v1/parents) ------------------
  // Role: Parent
  // No routes currently defined, will be there!
  static const String parentBase = '/parents';

  // ------------------ 📚 Academic Routes ------------------
  // Timetable Routes (/api/v1/timetable)
  // Any authenticated user
  static const String timetableByDivision = '/timetable/division'; // + /:id

  // Year Plan Routes (/api/v1/yearplan)
  // Any authenticated user
  static const String yearPlanByClass = '/yearplan/class'; // + /:id

  // ------------------ 📋 Attendance Routes (/api/v1/attendance) ------------------
  // Teacher: Create leave request
  static const String attendanceRequest = '/attendance/request';
  // Coordinator: Coordinator approval for leave
  static const String attendanceCoordinatorApproval =
      '/attendance/coordinator-approval';
  // Principal: Principal approval for leave
  static const String attendancePrincipalApproval =
      '/attendance/principal-approval';

  // ------------------ 💬 Communication Routes (/api/v1/communication) ------------------
  // Get all communication inbox (leave requests, mails, requests etc)
  static const String communicationInbox = '/communication';

  // ------------------ Common Headers ------------------
  static const String contentType = 'application/json';
  static const String authorization = 'Authorization';
  static const String bearer = 'Bearer';
}
