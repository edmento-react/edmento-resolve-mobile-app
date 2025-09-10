# Quick Reference Guide

## 🚀 Common Import Patterns

### Core Widgets
```dart
// Buttons
import 'package:edmentoresolve/core/widgets/buttons/primary_button.dart';

// Cards
import 'package:edmentoresolve/core/widgets/cards/app_card.dart';

// Forms
import 'package:edmentoresolve/core/widgets/forms/improved_text_field.dart';

// Layout
import 'package:edmentoresolve/core/widgets/layout/dashboard_scaffold.dart';

// Feedback
import 'package:edmentoresolve/core/widgets/feedback/loading_indicator.dart';

// Media
import 'package:edmentoresolve/core/widgets/media/avatar_widget.dart';

// Navigation
import 'package:edmentoresolve/core/widgets/navigation/app_bar_widget.dart';
```

### Core Utilities
```dart
// Configuration
import 'package:edmentoresolve/core/config/routes.dart';

// Constants
import 'package:edmentoresolve/core/constants/app_constants.dart';

// Data
import 'package:edmentoresolve/core/data/network/api_client.dart';

// Utils
import 'package:edmentoresolve/core/utils/debug_utils.dart';
```

### Features
```dart
// Authentication
import 'package:edmentoresolve/features/authentication/presentation/pages/login_page.dart';

// User Roles
import 'package:edmentoresolve/features/user_roles/teacher/presentation/widgets/task_card.dart';
import 'package:edmentoresolve/features/user_roles/student/presentation/pages/home_page.dart';
```

## 📁 Where to Put New Files

| Type | Location | Example |
|------|----------|---------|
| New Button | `core/widgets/buttons/` | `secondary_button.dart` |
| New Card | `core/widgets/cards/` | `info_card.dart` |
| New Form Field | `core/widgets/forms/` | `dropdown_field.dart` |
| New Layout | `core/widgets/layout/` | `app_scaffold.dart` |
| New Feedback | `core/widgets/feedback/` | `success_snackbar.dart` |
| New Media | `core/widgets/media/` | `video_player.dart` |
| New Navigation | `core/widgets/navigation/` | `drawer_widget.dart` |
| New Feature | `features/[feature_name]/` | `features/calendar/` |
| New User Role | `features/user_roles/[role]/` | `features/user_roles/counselor/` |
| New Constant | `core/constants/` | `validation_constants.dart` |
| New Utility | `core/utils/` | `date_utils.dart` |
| New Mixin | `shared/mixins/` | `validation_mixin.dart` |

## 🎯 Feature Structure Template

When creating a new feature, use this structure:

```
features/new_feature/
├── data/
│   ├── datasources/
│   │   ├── new_feature_remote_data_source.dart
│   │   └── new_feature_local_data_source.dart
│   ├── models/
│   │   └── new_feature_model.dart
│   └── repositories/
│       └── new_feature_repository_impl.dart
├── domain/
│   ├── entities/
│   │   └── new_feature_entity.dart
│   ├── repositories/
│   │   └── new_feature_repository.dart
│   └── usecases/
│       └── get_new_feature_usecase.dart
└── presentation/
    ├── bloc/
    │   └── new_feature_cubit.dart
    ├── pages/
    │   └── new_feature_page.dart
    └── widgets/
        └── new_feature_widget.dart
```

## 🔧 Naming Conventions

- **Folders**: `snake_case` (e.g., `user_roles`, `office_admin`)
- **Files**: `snake_case.dart` (e.g., `login_page.dart`, `task_card.dart`)
- **Classes**: `PascalCase` (e.g., `LoginPage`, `TaskCard`)
- **Variables**: `camelCase` (e.g., `userName`, `isLoading`)
- **Constants**: `SCREAMING_SNAKE_CASE` (e.g., `API_BASE_URL`)

## 📦 Barrel Exports

Always create `index.dart` files for easy importing:

```dart
// lib/core/widgets/buttons/index.dart
export 'primary_button.dart';
export 'secondary_button.dart';
export 'icon_button.dart';
```

Then import with:
```dart
import 'package:edmentoresolve/core/widgets/buttons/index.dart';
```

## 🚨 Common Mistakes to Avoid

1. ❌ Don't put feature-specific widgets in `core/widgets/`
2. ❌ Don't mix data and domain logic
3. ❌ Don't create inconsistent folder names (`widget` vs `widgets`)
4. ❌ Don't forget to update barrel exports when adding new files
5. ❌ Don't put business logic in presentation layer
6. ❌ Don't create deep nested folder structures (max 3-4 levels)

## ✅ Best Practices

1. ✅ Use barrel exports for clean imports
2. ✅ Follow clean architecture principles
3. ✅ Keep feature-specific code in feature folders
4. ✅ Use consistent naming conventions
5. ✅ Create reusable components in `core/widgets/`
6. ✅ Separate concerns properly (data, domain, presentation)
7. ✅ Document complex business logic
8. ✅ Use meaningful file and folder names
