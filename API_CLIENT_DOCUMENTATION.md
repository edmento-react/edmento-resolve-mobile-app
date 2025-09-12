# API Client Documentation

## Overview

The API client has been completely reworked to match the new routes documentation structure. The client is now organized into role-specific services and follows a clean architecture pattern.

## Structure

### Main Components

1. **ApiClient** - Core HTTP client with interceptors and error handling
2. **ApiService** - Main service with all endpoints (legacy support)
3. **Role-specific Services** - Dedicated services for each user role
4. **ApiClientFactory** - Factory for creating and managing API services
5. **Data Models** - Comprehensive models for all API responses

### Role-Specific Services

- **AuthApiService** - Authentication endpoints (public)
- **AdminApiService** - Admin-specific endpoints
- **CoordinatorApiService** - Coordinator-specific endpoints
- **TeacherApiService** - Teacher-specific endpoints
- **AcademicApiService** - Academic endpoints (all authenticated users)
- **AttendanceApiService** - Attendance and leave management
- **CommunicationApiService** - Communication and messaging

## Usage Examples

### Basic Setup

```dart
// In your dependency injection setup
final apiClient = ApiClient(storageService, networkInfo);
final apiFactory = ApiClientFactory(apiClient);

// Initialize auth headers
await apiClient.initializeAuthHeaders();
```

### Authentication

```dart
// Login
final authService = apiFactory.authApiService;
final result = await authService.login({
  'email': 'user@example.com',
  'password': 'password123'
});

// Verify OTP
final otpResult = await authService.verifyOtp(OtpVerificationModel(
  email: 'user@example.com',
  otp: '123456'
));

// Select Role
final roleResult = await authService.selectRole(RoleSelectionModel(
  roleId: 'role123',
  roleName: 'Teacher'
));
```

### Role-Specific Operations

#### Admin Operations

```dart
final adminService = apiFactory.adminApiService;

// Get all users for admin's school
final users = await adminService.getUsers();
```

#### Coordinator Operations

```dart
final coordinatorService = apiFactory.coordinatorApiService;

// Get coordinator timetable with assigned sections/classes
final timetable = await coordinatorService.getTimetable();

// Create substitution
final substitution = await coordinatorService.createSubstitution(
  CreateSubstitutionModel(
    originalTeacherId: 'teacher123',
    substituteTeacherId: 'substitute123',
    classId: 'class456',
    date: '2024-01-15',
    startTime: '09:00',
    endTime: '10:00',
    reason: 'Medical leave'
  )
);
```

#### Teacher Operations

```dart
final teacherService = apiFactory.teacherApiService;

// Get portion plans
final portionPlans = await teacherService.getPortionPlans();
```

#### Academic Operations (All Users)

```dart
final academicService = apiFactory.academicApiService;

// Get timetable by division
final timetable = await academicService.getTimetableByDivision('division123');

// Get year plan by class
final yearPlan = await academicService.getYearPlanByClass('class456');
```

#### Attendance Operations

```dart
final attendanceService = apiFactory.attendanceApiService;

// Teacher: Create leave request
final request = await attendanceService.createRequest(
  CreateAttendanceRequestModel(
    classId: 'class123',
    startDate: '2024-01-15',
    endDate: '2024-01-17',
    reason: 'Personal leave'
  )
);

// Coordinator: Approve leave request
final approval = await attendanceService.coordinatorApproval(
  AttendanceApprovalModel(
    requestId: 'request123',
    status: 'approved',
    notes: 'Approved for personal reasons'
  )
);
```

#### Communication Operations

```dart
final communicationService = apiFactory.communicationApiService;

// Get communication inbox
final inbox = await communicationService.getInbox();
```

## API Endpoints Reference

### Authentication Routes (`/api/v1/auth`)
- `POST /auth/login` - User login
- `POST /auth/logout` - User logout
- `POST /auth/verify-otp` - Verify OTP
- `POST /auth/update-password` - Update password (authenticated)
- `POST /auth/forgot-password/send-otp` - Send OTP for password reset
- `POST /auth/forgot-password/reset` - Reset password with OTP
- `POST /auth/select-role` - Select user role (authenticated)
- `GET /auth/positions` - Get all available positions
- `GET /auth/me/roles` - Get current user's roles

### Admin Routes (`/api/v1/admins`)
- `GET /admins/users` - Get all users for admin's school

### Coordinator Routes (`/api/v1/coordinators`)
- `GET /coordinators/timetable` - Get coordinator details with assigned sections/classes
- `POST /coordinators/substitution` - Create substitution

### Teacher Routes (`/api/v1/teachers`)
- `GET /teachers/portion-plan` - Get portion plans

### Academic Routes
- `GET /timetable/division/:id` - Get timetable by division ID (Any authenticated user)
- `GET /yearplan/class/:id` - Get year plan by class (Any authenticated user)

### Attendance Routes (`/api/v1/attendance`)
- `POST /attendance/request` - Create leave request (Teacher)
- `POST /attendance/coordinator-approval` - Coordinator approval for leave (Coordinator)
- `POST /attendance/principal-approval` - Principal approval for leave (Principal)

### Communication Routes (`/api/v1/communication`)
- `GET /communication` - Get all communication inbox (leave requests, mails, requests etc)

## Data Models

All data models are located in their respective feature directories:

- `lib/features/authentication/data/models/` - Auth-related models
- `lib/features/user_roles/office_admin/data/models/` - Admin-related models
- `lib/features/user_roles/coordinator/data/models/` - Coordinator-related models
- `lib/features/user_roles/teacher/data/models/` - Teacher-related models
- `lib/features/shared/data/models/` - Academic-related models
- `lib/features/shared/data/models/` - Attendance-related models
- `lib/features/shared/data/models/` - Communication-related models

## Error Handling

The API client includes comprehensive error handling through the `ApiClient` class, which maps Dio exceptions to custom failure types. All services automatically handle:

- Network connectivity issues
- Authentication errors
- Server errors
- Timeout errors
- Unknown errors

## Best Practices

1. **Use Role-Specific Services**: Always use the appropriate role-specific service for better organization and type safety.

2. **Initialize Auth Headers**: Always call `initializeAuthHeaders()` after creating the API client.

3. **Handle Errors**: Wrap API calls in try-catch blocks and handle specific error types.

4. **Use Models**: Always use the provided data models for request/response handling.

5. **Check Authentication**: Use `requiresAuthentication()` to check if an endpoint needs authentication.

## Migration from Old API Client

If you're migrating from the old API client:

1. Replace direct `ApiService` usage with role-specific services
2. Update model imports to use the new model locations
3. Use `ApiClientFactory` for centralized service access
4. Update error handling to use the new failure types

## Future Enhancements

- Student and Parent API services (when routes are defined)
- Caching layer for frequently accessed data
- Offline support with local storage
- Request/response logging and analytics
- Rate limiting and retry mechanisms
