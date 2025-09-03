import 'dart:async';

import '../../domain/entities/comm_message.dart';
import '../../domain/enums/comm_tab.dart';
import '../../domain/repositories/communication_repository.dart';

class MockCommunicationRepository implements ICommunicationRepository {
  @override
  Future<List<CommMessage>> fetch({
    required int page,
    required int pageSize,
    required CommTab tab,
  }) async {
    await Future.delayed(const Duration(milliseconds: 400));

    final now = DateTime.now();
    final today = now.subtract(const Duration(minutes: 2));
    final yesterday = now.subtract(const Duration(days: 1, minutes: 2));

    final list = <CommMessage>[
      CommMessage(
        id: '1',
        senderName: 'James Dutton',
        senderAvatar: 'https://i.pravatar.cc/100?img=5',
        subject: 'Exam Schedule Review Meeting',
        preview:
            'Please be reminded that the review meeting for the upcoming exam schedule is scheduled...',
        createdAt: today,
        status: CommStatusDot.red,
      ),
      CommMessage(
        id: '2',
        senderName: 'James Dutton',
        senderAvatar: 'https://i.pravatar.cc/100?img=11',
        subject: 'Exam Schedule Review Meeting',
        preview:
            'Please be reminded that the review meeting for the upcoming exam schedule is scheduled...',
        createdAt: today,
        status: CommStatusDot.yellow,
        attachmentName: 'report.docx',
        extraAttachments: 3,
      ),
      CommMessage(
        id: '3',
        senderName: 'James Dutton',
        senderAvatar: 'https://i.pravatar.cc/100?img=7',
        subject: 'Exam Schedule Review Meeting',
        preview:
            'Please be reminded that the review meeting for the upcoming exam schedule is scheduled...',
        createdAt: yesterday,
        status: CommStatusDot.red,
      ),
      CommMessage(
        id: '4',
        senderName: 'James Dutton',
        senderAvatar: 'https://i.pravatar.cc/100?img=13',
        subject: 'Exam Schedule Review Meeting',
        preview:
            'Please be reminded that the review meeting for the upcoming exam schedule is scheduled...',
        createdAt: yesterday,
        status: CommStatusDot.yellow,
        attachmentName: 'report.docx',
        extraAttachments: 3,
      ),
      CommMessage(
        id: '5',
        senderName: 'James Dutton',
        senderAvatar: 'https://i.pravatar.cc/100?img=13',
        subject: 'Leave Apply',
        preview:
            'Please be reminded that the review meeting for the upcoming exam schedule is scheduled...',
        createdAt: DateTime.now().subtract(Duration(days: 2)),
        status: CommStatusDot.yellow,
        attachmentName: 'report.docx',
        extraAttachments: 3,
      ),
    ];

    // Simple pagination for demo
    final start = page * pageSize;
    final end = (start + pageSize).clamp(0, list.length);
    if (start >= list.length) return [];
    return list.sublist(start, end);
  }
}
