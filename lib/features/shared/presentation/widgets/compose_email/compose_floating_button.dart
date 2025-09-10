import 'package:edmentoresolve/features/shared/presentation/pages/compose_email_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ComposeFloatingButton extends StatelessWidget {
  final String? initialTo;
  final String? initialSubject;
  final String? initialBody;
  final VoidCallback? onPressed;

  const ComposeFloatingButton({
    super.key,
    this.initialTo,
    this.initialSubject,
    this.initialBody,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed ?? () => _openComposeEmail(context),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 4,
      icon: Icon(Icons.edit, size: 20.sp),
      label: Text(
        'Compose',
        style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500),
      ),
    );
  }

  void _openComposeEmail(BuildContext context) {
    navigateToComposeEmail(
      context,
      // initialTo: initialTo,
      // initialSubject: initialSubject,
      // initialBody: initialBody,
    );
  }
}

// Compact version for smaller spaces
class ComposeFloatingButtonCompact extends StatelessWidget {
  final String? initialTo;
  final String? initialSubject;
  final String? initialBody;
  final VoidCallback? onPressed;

  const ComposeFloatingButtonCompact({
    super.key,
    this.initialTo,
    this.initialSubject,
    this.initialBody,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: onPressed ?? () => _openComposeEmail(context),
      backgroundColor: Colors.blue,
      foregroundColor: Colors.white,
      elevation: 4,
      child: Icon(Icons.edit, size: 24.sp),
    );
  }

  void _openComposeEmail(BuildContext context) {
    navigateToComposeEmail(
      context,
      // initialTo: initialTo,
      // initialSubject: initialSubject,
      // initialBody: initialBody,
    );
  }
}

// Gmail-style compose button
class GmailComposeButton extends StatelessWidget {
  final String? initialTo;
  final String? initialSubject;
  final String? initialBody;
  final VoidCallback? onPressed;

  const GmailComposeButton({
    super.key,
    this.initialTo,
    this.initialSubject,
    this.initialBody,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16.w),
      child: Material(
        color: Colors.blue,
        borderRadius: BorderRadius.circular(24.r),
        elevation: 2,
        child: InkWell(
          borderRadius: BorderRadius.circular(24.r),
          onTap: onPressed ?? () => _openComposeEmail(context),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.edit, color: Colors.white, size: 20.sp),
                SizedBox(width: 8.w),
                Text(
                  'Compose',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _openComposeEmail(BuildContext context) {
    navigateToComposeEmail(
      context,
      // initialTo: initialTo,
      // initialSubject: initialSubject,
      // initialBody: initialBody,
    );
  }
}
