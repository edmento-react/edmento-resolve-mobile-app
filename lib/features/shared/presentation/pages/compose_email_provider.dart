import 'package:edmentoresolve/features/shared/data/datasources/compose_email_remote_data_source.dart';
import 'package:edmentoresolve/features/shared/data/repositories/compose_email_repository_impl.dart';
import 'package:edmentoresolve/features/shared/domain/usecases/compose_email/save_draft_usecase.dart';
import 'package:edmentoresolve/features/shared/domain/usecases/compose_email/send_email_usecase.dart';
import 'package:edmentoresolve/features/shared/domain/usecases/compose_email/upload_attachment_usecase.dart';
import 'package:edmentoresolve/features/shared/presentation/bloc/compose_email_cubit.dart';
import 'package:edmentoresolve/features/shared/presentation/pages/compose_email_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ComposeEmailProvider extends StatelessWidget {
  final String? draftId;
  final String? initialTo;
  final String? initialSubject;
  final String? initialBody;
  final ComposeMode mode;

  const ComposeEmailProvider({
    super.key,
    this.draftId,
    this.initialTo,
    this.initialSubject,
    this.initialBody,
    this.mode = ComposeMode.compose,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        // Create data source
        final remoteDataSource = ComposeEmailRemoteDataSourceImpl();

        // Create repository
        final repository = ComposeEmailRepositoryImpl(remoteDataSource);

        // Create use cases
        final sendEmailUseCase = SendEmailUseCase(repository);
        final saveDraftUseCase = SaveDraftUseCase(repository);
        final uploadAttachmentUseCase = UploadAttachmentUseCase(repository);

        // Create and return cubit
        return ComposeEmailCubit(
          sendEmailUseCase: sendEmailUseCase,
          saveDraftUseCase: saveDraftUseCase,
          uploadAttachmentUseCase: uploadAttachmentUseCase,
          repository: repository,
        );
      },
      child: ComposeEmailPage(
        draftId: draftId,
        initialTo: initialTo,
        initialSubject: initialSubject,
        initialBody: initialBody,
        mode: mode,
      ),
    );
  }
}

// Convenience function to navigate to compose email
void navigateToComposeEmail(
  BuildContext context, {
  String? draftId,
  // String? initialTo,
  // String? initialSubject,
  // String? initialBody,
  ComposeMode mode = ComposeMode.compose,
}) {
  // Use go_router for navigation
  if (draftId != null) {
    context.push('/compose-email/draft/$draftId');
  } else {
    switch (mode) {
      case ComposeMode.compose:
        context.push('/compose-email');
        break;
      case ComposeMode.schedule:
        context.push('/compose-email/schedule');
        break;
      case ComposeMode.leave:
        context.push('/compose-email/leave');
        break;
    }
  }
}
