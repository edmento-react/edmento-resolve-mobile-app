# Compose Email Feature Usage Guide

## Overview
The Compose Email feature provides a Gmail-style email composition interface that can be used across all user roles in the application. It follows clean architecture principles with BLoC/Cubit state management.

## Features
- ✅ Gmail-style compose interface
- ✅ Rich text editing with formatting options
- ✅ File attachments support
- ✅ Email templates
- ✅ Draft saving and loading
- ✅ Priority settings
- ✅ CC/BCC support
- ✅ Schedule send (placeholder)
- ✅ Clean architecture with BLoC/Cubit
- ✅ Responsive design with ScreenUtil

## Quick Start

### 1. Basic Usage
```dart
import 'package:edmentoresolve/features/shared/compose_email/presentation/pages/compose_email_provider.dart';

// Navigate to compose email
navigateToComposeEmail(context);

// With initial content
navigateToComposeEmail(
  context,
  initialTo: 'user@example.com',
  initialSubject: 'Meeting Request',
  initialBody: 'Hi there,\n\nI would like to schedule a meeting...',
);
```

### 2. Using Compose Buttons
```dart
import 'package:edmentoresolve/features/shared/compose_email/presentation/widgets/compose_floating_button.dart';

// Floating action button
ComposeFloatingButton(
  initialTo: 'user@example.com',
  onPressed: () {
    // Custom action or use default
  },
)

// Compact version
ComposeFloatingButtonCompact()

// Gmail-style button
GmailComposeButton()
```

### 3. Integration in Pages
```dart
class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('My Page')),
      body: MyContent(),
      floatingActionButton: ComposeFloatingButton(),
    );
  }
}
```

## Architecture

### Domain Layer
- **Entities**: `EmailEntity`, `EmailAttachment`, `EmailTemplate`
- **Repositories**: `ComposeEmailRepository` (abstract)
- **Use Cases**: `SendEmailUseCase`, `SaveDraftUseCase`, `UploadAttachmentUseCase`

### Data Layer
- **Data Sources**: `ComposeEmailRemoteDataSource` (abstract)
- **Models**: `EmailModel` (extends `EmailEntity`)
- **Repository Implementation**: `ComposeEmailRepositoryImpl`

### Presentation Layer
- **BLoC**: `ComposeEmailCubit` with `ComposeEmailState`
- **Pages**: `ComposeEmailPage`, `ComposeEmailProvider`
- **Widgets**: Various UI components for compose interface

## State Management

### ComposeEmailState
```dart
class ComposeEmailState {
  final ComposeEmailStatus status;
  final String to, cc, bcc, subject, body;
  final List<EmailAttachment> attachments;
  final EmailPriority priority;
  final bool showCc, showBcc, showAttachments, showMoreOptions;
  // ... other properties
}
```

### ComposeEmailStatus
```dart
enum ComposeEmailStatus {
  initial,
  idle,
  sending,
  sent,
  savingDraft,
  draftSaved,
  uploadingAttachment,
  loadingTemplates,
  error,
}
```

## Customization

### 1. Custom Email Templates
```dart
// Load templates
context.read<ComposeEmailCubit>().loadEmailTemplates();

// Apply template
context.read<ComposeEmailCubit>().applyTemplate(template);
```

### 2. File Attachments
```dart
// Upload attachment
context.read<ComposeEmailCubit>().uploadAttachment(filePath);

// Remove attachment
context.read<ComposeEmailCubit>().removeAttachment(attachmentId);
```

### 3. Priority Settings
```dart
// Update priority
context.read<ComposeEmailCubit>().updatePriority(EmailPriority.high);
```

## UI Components

### EmailRecipientsField
Custom text field for email recipients with validation.

### RichTextEditor
Text editor with formatting options (bold, italic, underline, lists).

### AttachmentListWidget
Displays attached files with icons and remove functionality.

### PrioritySelector
Visual priority selector with color-coded options.

### EmailTemplatesDialog
Modal dialog for selecting and managing email templates.

## Error Handling
The feature includes comprehensive error handling:
- Network errors
- Validation errors
- File upload errors
- Template loading errors

## Responsive Design
Uses `flutter_screenutil` for responsive design across different screen sizes.

## Future Enhancements
- [ ] Real file picker integration
- [ ] Emoji picker
- [ ] Advanced formatting (font size, color)
- [ ] Schedule send functionality
- [ ] Email signature support
- [ ] Auto-save drafts
- [ ] Email validation
- [ ] Rich text formatting with HTML

## Dependencies
- `flutter_bloc`: State management
- `flutter_screenutil`: Responsive design
- `dio`: HTTP client (for API calls)
- `retrofit`: API service generation

## Integration Notes
1. The feature is designed to be role-agnostic and can be used by all user types
2. All API calls are mocked in the current implementation
3. File attachment functionality is placeholder and needs real implementation
4. The UI follows Material Design principles with Gmail-inspired styling
5. State is managed locally and doesn't persist across app restarts (except for drafts)
