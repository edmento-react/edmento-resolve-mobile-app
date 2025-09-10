# Flutter Project Structure Guide

## Overview
This document explains the refined and organized folder structure of the Edmento Resolve Flutter application. The structure follows clean architecture principles and provides clear separation of concerns for better maintainability and scalability.

## 📁 Root Structure

```
lib/
├── core/                    # Core functionality shared across the app
├── features/               # Feature modules organized by functionality
├── shared/                 # Shared components across features
├── examples/               # Development examples and usage guides
└── main.dart              # Application entry point
```

## 🏗️ Core Module (`lib/core/`)

The core module contains all shared functionality that can be used across different features.

### Configuration (`lib/core/config/`)
- **Purpose**: App-wide configuration and routing
- **Files**:
  - `routes.dart` - Application routes definition
  - `routing_transaction.dart` - Route transition configurations

### Constants (`lib/core/constants/`)
- **Purpose**: Application-wide constants
- **Files**:
  - `api_constants.dart` - API endpoints and configurations
  - `app_constants.dart` - General app constants
  - `color_constant.dart` - Color definitions
  - `dimensions.dart` - Size and spacing constants
  - `padding_constant.dart` - Padding and margin constants
  - `style_constant.dart` - Text and UI style constants

### Data Layer (`lib/core/data/`)
- **Purpose**: Data management and persistence
- **Structure**:
  ```
  data/
  ├── database/           # Local database (SQLite)
  │   ├── app_database.dart
  │   ├── database_service.dart
  │   ├── daos/          # Data Access Objects
  │   └── entities/      # Database entities
  ├── network/           # Network layer
  │   ├── api_client.dart
  │   ├── api_service.dart
  │   └── network_info.dart
  └── storage/           # Local storage utilities
      └── storage_util.dart
  ```

### Domain Layer (`lib/core/domain/`)
- **Purpose**: Business logic and use cases
- **Structure**:
  ```
  domain/
  ├── entities/          # Domain entities
  ├── repositories/      # Repository interfaces
  ├── usecases/         # Business use cases
  └── resources/        # Data state management
  ```

### Error Handling (`lib/core/error/`)
- **Purpose**: Centralized error management
- **Files**:
  - `exceptions.dart` - Custom exceptions

### Security (`lib/core/security/`)
- **Purpose**: Security-related functionality
- **Files**:
  - `freerasp_bootstrap.dart` - Security framework setup
  - `security_cubit.dart` - Security state management

### Theme (`lib/core/theme/`)
- **Purpose**: Application theming
- **Files**:
  - `app_theme.dart` - Main theme configuration

### Utils (`lib/core/utils/`)
- **Purpose**: Utility functions
- **Files**:
  - `debug_utils.dart` - Debug utilities
  - `image_utils.dart` - Image processing utilities
  - `performance_utils.dart` - Performance monitoring
  - `general_functions.dart` - General helper functions

### Widgets (`lib/core/widgets/`)
- **Purpose**: Reusable UI components organized by category
- **Structure**:
  ```
  widgets/
  ├── buttons/           # Button components
  │   ├── primary_button.dart
  │   ├── button_widget.dart
  │   └── improved_primary_button.dart
  ├── cards/            # Card components
  │   ├── app_card.dart
  │   ├── card_widget.dart
  │   ├── feature_card.dart
  │   └── glass_container.dart
  ├── forms/            # Form input components
  │   ├── improved_text_field.dart
  │   └── reusable_text_field.dart
  ├── layout/           # Layout and scaffolding
  │   ├── dashboard_scaffold.dart
  │   ├── app_bottom_nav.dart
  │   ├── role_bottom_navigation.dart
  │   └── tab_bar_widget.dart
  ├── feedback/         # User feedback components
  │   ├── loading_indicator.dart
  │   ├── loading_overlay_widget.dart
  │   ├── global_snackbar.dart
  │   └── empty_state_widget.dart
  ├── media/            # Media-related components
  │   ├── optimized_image.dart
  │   ├── avatar_widget.dart
  │   ├── gradient_icon.dart
  │   └── icon_widget.dart
  └── navigation/       # Navigation components
      ├── app_bar_widget.dart
      ├── sliver_bar_widget.dart
      └── bottom_sheet_overlay.dart
  ```

## 🎯 Features Module (`lib/features/`)

Features are organized by functionality and follow clean architecture principles.

### Authentication (`lib/features/authentication/`)
- **Purpose**: User authentication and authorization
- **Structure**: Complete clean architecture (data, domain, presentation)

### Dashboard (`lib/features/dashboard/`)
- **Purpose**: Main dashboard functionality
- **Structure**: Presentation layer only

### Notifications (`lib/features/notifications/`)
- **Purpose**: Notification management
- **Structure**: Complete clean architecture

### Profile (`lib/features/profile/`)
- **Purpose**: User profile management
- **Structure**: Presentation layer only

### Settings (`lib/features/settings/`)
- **Purpose**: Application settings
- **Structure**: Presentation layer only

### Splash (`lib/features/splash/`)
- **Purpose**: Splash screen
- **Structure**: Presentation layer only

### User Roles (`lib/features/user_roles/`)
- **Purpose**: Role-specific functionality
- **Structure**: Each role has complete clean architecture
- **Roles**:
  - `coordinator/` - Coordinator-specific features
  - `office_admin/` - Office admin features
  - `parent/` - Parent features
  - `principal/` - Principal features
  - `student/` - Student features
  - `teacher/` - Teacher features

## 🔄 Shared Module (`lib/shared/`)

Components shared across multiple features.

### Mixins (`lib/shared/mixins/`)
- **Purpose**: Reusable mixins
- **Files**:
  - `throttle_mixin.dart` - Throttling functionality
  - `widget_lifecycle_manager.dart` - Widget lifecycle management

### Extensions (`lib/shared/extensions/`)
- **Purpose**: Dart extensions for common types
- **Future additions**:
  - `string_extensions.dart`
  - `date_extensions.dart`
  - `context_extensions.dart`

### Enums (`lib/shared/enums/`)
- **Purpose**: Shared enumerations
- **Future additions**:
  - `user_role.dart`
  - `notification_type.dart`
  - `app_status.dart`

## 📚 Examples (`lib/examples/`)

Development examples and usage guides.

## 🎨 Clean Architecture Pattern

Each feature follows the clean architecture pattern:

```
feature/
├── data/               # Data layer
│   ├── datasources/   # Data sources (API, Local)
│   ├── models/        # Data models
│   └── repositories/  # Repository implementations
├── domain/            # Domain layer
│   ├── entities/      # Business entities
│   ├── repositories/  # Repository interfaces
│   └── usecases/      # Business use cases
└── presentation/      # Presentation layer
    ├── bloc/          # State management
    ├── pages/         # UI pages
    └── widgets/       # Feature-specific widgets
```

## 📦 Import Guidelines

### Core Imports
```dart
// Use barrel exports for clean imports
import 'package:edmentoresolve/core/index.dart';
import 'package:edmentoresolve/core/widgets/buttons/index.dart';
import 'package:edmentoresolve/core/widgets/cards/index.dart';
```

### Feature Imports
```dart
// Import specific feature components
import 'package:edmentoresolve/features/authentication/presentation/pages/login_page.dart';
import 'package:edmentoresolve/features/user_roles/teacher/presentation/widgets/task_card.dart';
```

### Shared Imports
```dart
// Import shared components
import 'package:edmentoresolve/shared/mixins/throttle_mixin.dart';
```

## 🚀 Benefits of This Structure

1. **Clear Separation of Concerns**: Each module has a specific purpose
2. **Scalability**: Easy to add new features and components
3. **Maintainability**: Logical organization makes code easier to maintain
4. **Team Collaboration**: Clear conventions for all developers
5. **Reusability**: Core widgets and utilities are easily reusable
6. **Consistency**: All features follow the same architectural pattern
7. **Performance**: Barrel exports reduce import complexity

## 🔧 Development Guidelines

1. **New Features**: Follow the clean architecture pattern
2. **New Widgets**: Place in appropriate category in `core/widgets/`
3. **Constants**: Add to appropriate constant file in `core/constants/`
4. **Utilities**: Add to `core/utils/` or `shared/` as appropriate
5. **User Roles**: Add role-specific features under `features/user_roles/`
6. **Imports**: Use barrel exports when available
7. **Naming**: Follow consistent naming conventions (widgets, not widget)

## 📝 Migration Notes

- All import statements have been updated to reflect the new structure
- Barrel export files (`index.dart`) have been created for easy importing
- Inconsistent naming has been standardized (widgets, bloc casing)
- Examples have been moved to a dedicated folder
- User role features have been grouped under `user_roles/`

This structure provides a solid foundation for scalable Flutter development while maintaining clean architecture principles and clear organization.
