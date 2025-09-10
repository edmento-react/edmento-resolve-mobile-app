import 'dart:async';

import 'package:edmentoresolve/features/shared/domain/entities/person.dart';
import 'package:edmentoresolve/features/shared/presentation/bloc/compose_email_cubit.dart';
import 'package:edmentoresolve/features/shared/presentation/bloc/compose_email_state.dart';
import 'package:edmentoresolve/features/shared/presentation/widgets/compose_email/attachment_list_widget.dart';
import 'package:edmentoresolve/features/shared/presentation/widgets/compose_email/email_recipients_field.dart';
import 'package:edmentoresolve/features/shared/presentation/widgets/compose_email/leave_date_range_picker.dart';
import 'package:edmentoresolve/features/shared/presentation/widgets/compose_email/rich_text_editor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

enum ComposeMode {
  compose, // Immediate send
  schedule, // Schedule send
  leave, // Leave application with template
}

class ComposeEmailPage extends StatelessWidget {
  final String? draftId;
  final String? initialTo;
  final String? initialSubject;
  final String? initialBody;
  final ComposeMode mode;

  const ComposeEmailPage({
    super.key,
    this.draftId,
    this.initialTo,
    this.initialSubject,
    this.initialBody,
    this.mode = ComposeMode.compose,
  });

  @override
  Widget build(BuildContext context) {
    return _ComposeEmailPageView(
      draftId: draftId,
      initialTo: initialTo,
      initialSubject: initialSubject,
      initialBody: initialBody,
      mode: mode,
    );
  }
}

class _ComposeEmailPageView extends StatefulWidget {
  final String? draftId;
  final String? initialTo;
  final String? initialSubject;
  final String? initialBody;
  final ComposeMode mode;

  const _ComposeEmailPageView({
    this.draftId,
    this.initialTo,
    this.initialSubject,
    this.initialBody,
    required this.mode,
  });

  @override
  State<_ComposeEmailPageView> createState() => __ComposeEmailPageStateView();
}

class __ComposeEmailPageStateView extends State<_ComposeEmailPageView> {
  late final TextEditingController _subjectController;
  late final TextEditingController _bodyController;

  @override
  void initState() {
    super.initState();

    // Handle leave template
    String initialSubject = widget.initialSubject ?? '';
    String initialBody = widget.initialBody ?? '';

    if (widget.mode == ComposeMode.leave) {
      initialSubject = 'Leave Application';
      initialBody = '''Dear [Manager's Name],

I am writing to request a leave of absence from [Start Date] to [End Date] for [Reason].

I will ensure that all my pending work is completed before my departure and will be available for any handover if required.

Thank you for your consideration.

Best regards,
[Your Name]''';
    }

    _subjectController = TextEditingController(text: initialSubject);
    _bodyController = TextEditingController(text: initialBody);

    // Initialize the cubit with initial values - use microtask for better performance
    scheduleMicrotask(() {
      if (mounted) {
        final cubit = context.read<ComposeEmailCubit>();

        // Update cubit state with initial values
        if (widget.initialTo != null) {
          // Parse initial recipients from string
          final initialRecipients = _parseInitialRecipients(widget.initialTo!);
          cubit.updateToRecipients(initialRecipients);
        }
        // cubit.updateSubject(initialSubject);
        // cubit.updateBody(initialBody);
      }
    });
  }

  @override
  void dispose() {
    _subjectController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ComposeEmailCubit, ComposeEmailState>(
      listener: (context, state) {
        switch (state.status) {
          case ComposeEmailStatus.sent:
            _showSnackBar('Email sent successfully!', Colors.green);
            context.pop();
            break;
          case ComposeEmailStatus.draftSaved:
            _showSnackBar('Draft saved successfully!', Colors.green);
            break;
          case ComposeEmailStatus.error:
            _showSnackBar(
              state.errorMessage ?? 'An error occurred',
              Colors.red,
            );
            break;
          default:
            break;
        }
      },
      child: Scaffold(
        backgroundColor: Colors.grey[50],
        appBar: _buildAppBar(),
        body: SingleChildScrollView(child: _buildBody()),
        bottomNavigationBar: _buildBottomBar(),
      ),
    );
  }

  // -------------------- AppBar --------------------
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.close, color: Colors.black54),
        onPressed: _handleClose,
      ),
      title: Text(
        _getAppBarTitle(),
        style: TextStyle(
          color: Colors.black87,
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.attach_file, color: Colors.black54),
          onPressed: _handleAttachFile,
        ),
      ],
    );
  }

  // -------------------- Body --------------------
  Widget _buildBody() {
    return BlocBuilder<ComposeEmailCubit, ComposeEmailState>(
      builder: (context, state) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _recipientsSection(state),
            SizedBox(height: 16.h),
            _subjectSection(state),
            SizedBox(height: 16.h),
            _dateRangeSection(state),
            SizedBox(height: 16.h),
            _bodySection(state),
            SizedBox(height: 16.h),
            if (state.showAttachments) ...[
              AttachmentListWidget(
                attachments: state.attachments,
                onRemoveAttachment: (attachmentId) {
                  context.read<ComposeEmailCubit>().removeAttachment(
                    attachmentId,
                  );
                },
              ),
              SizedBox(height: 16.h),
            ],
          ],
        );
      },
    );
  }

  Widget _recipientsSection(ComposeEmailState state) {
    return _sectionWrapper(
      child: Column(
        children: [
          EmailRecipientsField(
            label: 'To',
            selectedRecipients: state.toRecipients,
            onRecipientsChanged: context
                .read<ComposeEmailCubit>()
                .updateToRecipients,
            isRequired: true,
          ),
          if (state.showCc)
            EmailRecipientsField(
              label: 'Cc',
              selectedRecipients: state.ccRecipients,
              onRecipientsChanged: context
                  .read<ComposeEmailCubit>()
                  .updateCcRecipients,
            ),
          if (state.showBcc)
            EmailRecipientsField(
              label: 'Bcc',
              selectedRecipients: state.bccRecipients,
              onRecipientsChanged: context
                  .read<ComposeEmailCubit>()
                  .updateBccRecipients,
            ),
        ],
      ),
    );
  }

  Widget _subjectSection(ComposeEmailState state) {
    return _sectionWrapper(
      child: TextField(
        controller: _subjectController,
        decoration: InputDecoration(
          hintText: 'Subject',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 16.w,
            vertical: 12.h,
          ),
        ),
        style: TextStyle(fontSize: 16.sp),
        onChanged: context.read<ComposeEmailCubit>().updateSubject,
      ),
    );
  }

  Widget _dateRangeSection(ComposeEmailState state) {
    // Only show date range picker for leave mode
    if (widget.mode != ComposeMode.leave) {
      return const SizedBox.shrink();
    }

    return _sectionWrapper(
      child: LeaveDateRangePicker(
        startDate: state.leaveStartDate,
        endDate: state.leaveEndDate,
        onStartDateChanged: (date) {
          context.read<ComposeEmailCubit>().updateLeaveStartDate(date);
          _updateLeaveTemplateWithDates();
        },
        onEndDateChanged: (date) {
          context.read<ComposeEmailCubit>().updateLeaveEndDate(date);
          _updateLeaveTemplateWithDates();
        },
      ),
    );
  }

  Widget _bodySection(ComposeEmailState state) {
    return _sectionWrapper(
      child: SizedBox(
        height: 400.h,
        child: RichTextEditor(
          controller: _bodyController,
          onChanged: context.read<ComposeEmailCubit>().updateBody,
        ),
      ),
    );
  }

  // -------------------- Bottom Bar --------------------
  Widget _buildBottomBar() {
    return BlocBuilder<ComposeEmailCubit, ComposeEmailState>(
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withValues(alpha: 0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    _toggleButton(
                      label: 'Cc',
                      isActive: state.showCc,
                      onTap: () {
                        context.read<ComposeEmailCubit>().toggleCcVisibility();
                      },
                    ),
                    _toggleButton(
                      label: 'Bcc',
                      isActive: state.showBcc,
                      onTap: () {
                        context.read<ComposeEmailCubit>().toggleBccVisibility();
                      },
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      context.read<ComposeEmailCubit>().saveDraft();
                    },
                    child: Text(
                      'Save Draft',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                  SizedBox(width: 5.w),
                  ElevatedButton(
                    onPressed:
                        state.canSend &&
                            state.status != ComposeEmailStatus.sending
                        ? () {
                            _handleSendAction();
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _getSendButtonColor(),
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(
                        horizontal: 24.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                    ),
                    child: state.status == ComposeEmailStatus.sending
                        ? SizedBox(
                            width: 16.w,
                            height: 16.h,
                            child: const CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                        : Text(
                            _getSendButtonText(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  // -------------------- Helpers --------------------
  Widget _sectionWrapper({required Widget child}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: child,
    );
  }

  Widget _toggleButton({
    required String label,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return TextButton.icon(
      style: TextButton.styleFrom(padding: EdgeInsets.zero),
      onPressed: onTap,
      icon: Icon(
        Icons.add,
        size: 18.sp,
        color: isActive ? Colors.blue : Colors.grey,
      ),
      label: Text(
        label,
        style: TextStyle(
          color: isActive ? Colors.blue : Colors.grey,
          fontSize: 14.sp,
        ),
      ),
    );
  }

  void _handleClose() {
    final cubit = context.read<ComposeEmailCubit>();
    if (cubit.state.hasContent) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: const Text('Discard Draft?'),
          content: const Text(
            'You have unsaved changes. Do you want to discard them?',
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                context.pop();
                context.pop();
              },
              child: const Text('Discard'),
            ),
            ElevatedButton(
              onPressed: () {
                context.pop();
                cubit.saveDraft();
                context.pop();
              },
              child: const Text('Save Draft'),
            ),
          ],
        ),
      );
    } else {
      context.pop();
    }
  }

  void _handleAttachFile() {
    _showSnackBar('File attachment feature coming soon!', Colors.blue);
  }

  void _showScheduleDialog() {
    DateTime selectedDate = DateTime.now().add(const Duration(days: 1));
    TimeOfDay selectedTime = const TimeOfDay(hour: 9, minute: 0);

    showDialog(
      context: context,
      builder: (_) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('Schedule Send'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Date'),
                subtitle: Text(
                  '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
                trailing: const Icon(Icons.calendar_today),
                onTap: () async {
                  final date = await showDatePicker(
                    context: context,
                    initialDate: selectedDate,
                    firstDate: DateTime.now(),
                    lastDate: DateTime.now().add(const Duration(days: 365)),
                  );
                  if (date != null) {
                    setState(() {
                      selectedDate = date;
                    });
                  }
                },
              ),
              ListTile(
                title: const Text('Time'),
                subtitle: Text(selectedTime.format(context)),
                trailing: const Icon(Icons.access_time),
                onTap: () async {
                  final time = await showTimePicker(
                    context: context,
                    initialTime: selectedTime,
                  );
                  if (time != null) {
                    setState(() {
                      selectedTime = time;
                    });
                  }
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final scheduledDateTime = DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                );
                context.read<ComposeEmailCubit>().scheduleEmail(
                  scheduledDateTime,
                );
                context.pop();
              },
              child: const Text('Schedule'),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  String _getAppBarTitle() {
    switch (widget.mode) {
      case ComposeMode.compose:
        return 'Compose';
      case ComposeMode.schedule:
        return 'Schedule Email';
      case ComposeMode.leave:
        return 'Leave Application';
    }
  }

  String _getSendButtonText() {
    switch (widget.mode) {
      case ComposeMode.compose:
        return 'Send';
      case ComposeMode.schedule:
        return 'Schedule';
      case ComposeMode.leave:
        return 'Submit';
    }
  }

  Color _getSendButtonColor() {
    switch (widget.mode) {
      case ComposeMode.compose:
        return Colors.blue;
      case ComposeMode.schedule:
        return Colors.orange;
      case ComposeMode.leave:
        return Colors.green;
    }
  }

  void _handleSendAction() {
    switch (widget.mode) {
      case ComposeMode.compose:
        context.read<ComposeEmailCubit>().sendEmail();
        break;
      case ComposeMode.schedule:
        _showScheduleDialog();
        break;
      case ComposeMode.leave:
        context.read<ComposeEmailCubit>().sendEmail();
        break;
    }
  }

  void _updateLeaveTemplateWithDates() {
    if (widget.mode != ComposeMode.leave) return;

    final state = context.read<ComposeEmailCubit>().state;
    final startDate = state.leaveStartDate;
    final endDate = state.leaveEndDate;

    if (startDate != null && endDate != null) {
      final startDateStr = _formatDate(startDate);
      final endDateStr = _formatDate(endDate);

      if (startDate == endDate) {
        final updatedBody =
            '''Dear [Manager's Name],

I am writing to request a leave of absence on $startDateStr for [Reason].

I will ensure that all my pending work is completed before my departure and will be available for any handover if required.

Thank you for your consideration.

Best regards,
[Your Name]''';

        _bodyController.text = updatedBody;
        context.read<ComposeEmailCubit>().updateBody(updatedBody);
      } else {
        final updatedBody =
            '''Dear [Manager's Name],

I am writing to request a leave of absence from $startDateStr to $endDateStr for [Reason].

I will ensure that all my pending work is completed before my departure and will be available for any handover if required.

Thank you for your consideration.

Best regards,
[Your Name]''';

        _bodyController.text = updatedBody;
        context.read<ComposeEmailCubit>().updateBody(updatedBody);
      }
    }
  }

  String _formatDate(DateTime date) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  List<Person> _parseInitialRecipients(String recipientsString) {
    if (recipientsString.isEmpty) return [];

    final emails = recipientsString.split(',').map((e) => e.trim()).toList();
    return emails.map((email) {
      // Create a basic Person object from email
      final name = email
          .split('@')
          .first
          .replaceAll('.', ' ')
          .split(' ')
          .map(
            (word) => word.isNotEmpty
                ? word[0].toUpperCase() + word.substring(1)
                : '',
          )
          .join(' ');

      return Person(
        id: email,
        name: name,
        email: email,
        positionName: 'Unknown',
      );
    }).toList();
  }
}
