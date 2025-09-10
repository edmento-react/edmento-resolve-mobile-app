# Flutter Project Folder Structure Reorganization Plan

## Current Issues Identified:
1. **Inconsistent naming conventions** (widget vs widgets, Bloc vs bloc)
2. **Scattered core widgets** without proper categorization
3. **Incomplete clean architecture** in some features
4. **Mixed organization patterns** across features
5. **Examples folder** in core (should be in development tools)

## Proposed New Structure:

```
lib/
├── core/                           # Core functionality shared across app
│   ├── config/                     # App configuration
│   │   ├── app_config.dart
│   │   ├── environment.dart
│   │   └── routes.dart
│   ├── constants/                  # App-wide constants
│   │   ├── api_constants.dart
│   │   ├── app_constants.dart
│   │   ├── color_constants.dart
│   │   ├── dimension_constants.dart
│   │   ├── padding_constants.dart
│   │   └── style_constants.dart
│   ├── data/                       # Core data layer
│   │   ├── database/
│   │   │   ├── app_database.dart
│   │   │   ├── database_service.dart
│   │   │   ├── daos/
│   │   │   └── entities/
│   │   ├── network/
│   │   │   ├── api_client.dart
│   │   │   ├── api_service.dart
│   │   │   └── network_info.dart
│   │   └── storage/
│   │       └── storage_util.dart
│   ├── domain/                     # Core domain layer
│   │   ├── entities/
│   │   ├── repositories/
│   │   └── usecases/
│   ├── error/                      # Error handling
│   │   ├── exceptions.dart
│   │   ├── failures.dart
│   │   └── error_handler.dart
│   ├── security/                   # Security features
│   │   ├── freerasp_bootstrap.dart
│   │   └── security_cubit.dart
│   ├── theme/                      # App theming
│   │   ├── app_theme.dart
│   │   ├── color_scheme.dart
│   │   └── text_theme.dart
│   ├── utils/                      # Utility functions
│   │   ├── debug_utils.dart
│   │   ├── image_utils.dart
│   │   ├── performance_utils.dart
│   │   └── validators.dart
│   └── widgets/                    # Reusable UI components
│       ├── buttons/
│       │   ├── primary_button.dart
│       │   ├── secondary_button.dart
│       │   └── icon_button.dart
│       ├── cards/
│       │   ├── app_card.dart
│       │   ├── feature_card.dart
│       │   └── glass_container.dart
│       ├── forms/
│       │   ├── text_field.dart
│       │   ├── dropdown_field.dart
│       │   └── date_picker_field.dart
│       ├── layout/
│       │   ├── app_scaffold.dart
│       │   ├── dashboard_scaffold.dart
│       │   ├── bottom_navigation.dart
│       │   └── tab_bar.dart
│       ├── feedback/
│       │   ├── loading_indicator.dart
│       │   ├── loading_overlay.dart
│       │   ├── global_snackbar.dart
│       │   └── empty_state.dart
│       ├── media/
│       │   ├── optimized_image.dart
│       │   ├── avatar_widget.dart
│       │   └── gradient_icon.dart
│       └── navigation/
│           ├── app_bar_widget.dart
│           ├── sliver_bar_widget.dart
│           └── bottom_sheet_overlay.dart
├── features/                       # Feature modules
│   ├── authentication/             # Auth feature
│   │   ├── data/
│   │   │   ├── datasources/
│   │   │   ├── models/
│   │   │   └── repositories/
│   │   ├── domain/
│   │   │   ├── entities/
│   │   │   ├── repositories/
│   │   │   └── usecases/
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── dashboard/                  # Dashboard feature
│   │   └── presentation/
│   │       ├── bloc/
│   │       ├── pages/
│   │       └── widgets/
│   ├── notifications/              # Notifications feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── profile/                    # Profile feature
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── settings/                   # Settings feature
│   │   └── presentation/
│   ├── splash/                     # Splash screen
│   │   └── presentation/
│   └── user_roles/                 # User role-specific features
│       ├── coordinator/
│       ├── office_admin/
│       ├── parent/
│       ├── principal/
│       ├── student/
│       └── teacher/
├── shared/                         # Shared components across features
│   ├── mixins/
│   │   ├── throttle_mixin.dart
│   │   └── widget_lifecycle_manager.dart
│   ├── extensions/
│   │   ├── string_extensions.dart
│   │   ├── date_extensions.dart
│   │   └── context_extensions.dart
│   └── enums/
│       ├── user_role.dart
│       ├── notification_type.dart
│       └── app_status.dart
└── main.dart
```

## Key Improvements:

### 1. **Core Reorganization**
- **config/**: Centralized configuration management
- **data/**: All data-related core functionality
- **domain/**: Core domain logic and entities
- **widgets/**: Categorized by functionality (buttons, cards, forms, etc.)

### 2. **Feature Consistency**
- All features follow clean architecture pattern
- Consistent naming: `widgets/` (not `widget/`)
- Consistent casing: `bloc/` (not `Bloc/`)

### 3. **User Roles Organization**
- Grouped role-specific features under `user_roles/`
- Each role has complete clean architecture

### 4. **Shared Components**
- `shared/` folder for cross-feature components
- `mixins/`, `extensions/`, `enums/` for reusable code

### 5. **Widget Categorization**
- **buttons/**: All button variants
- **cards/**: Card components
- **forms/**: Form input components
- **layout/**: Layout and scaffolding components
- **feedback/**: Loading, error, success states
- **media/**: Image, avatar, icon components
- **navigation/**: Navigation-related widgets

## Migration Steps:
1. Create new folder structure
2. Move files to appropriate locations
3. Update import statements
4. Update barrel exports (index.dart files)
5. Test compilation
6. Update documentation

## Benefits:
- **Easier navigation**: Logical grouping of related files
- **Better maintainability**: Clear separation of concerns
- **Consistent patterns**: All features follow same structure
- **Scalability**: Easy to add new features and components
- **Team collaboration**: Clear conventions for all developers
