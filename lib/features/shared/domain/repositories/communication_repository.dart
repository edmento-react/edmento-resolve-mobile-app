import 'package:edmentoresolve/features/shared/domain/entities/communication_message.dart';
import 'package:edmentoresolve/features/shared/domain/enums/communication_tab.dart';

/// Abstract repository interface for communication - shared across all user roles
abstract class ICommunicationRepository {
  /// Get messages for a specific tab
  Future<List<CommunicationMessage>> getMessages({
    required CommunicationTab tab,
    int page = 1,
    int limit = 20,
    String? searchQuery,
  });

  /// Get a specific message by ID
  Future<CommunicationMessage?> getMessageById(String id);

  /// Send a new message
  Future<CommunicationMessage> sendMessage(CommunicationMessage message);

  /// Save message as draft
  Future<CommunicationMessage> saveDraft(CommunicationMessage message);

  /// Update an existing message
  Future<CommunicationMessage> updateMessage(CommunicationMessage message);

  /// Delete a message
  Future<void> deleteMessage(String id);

  /// Mark message as read
  Future<void> markAsRead(String id);

  /// Mark message as unread
  Future<void> markAsUnread(String id);

  /// Archive a message
  Future<void> archiveMessage(String id);

  /// Unarchive a message
  Future<void> unarchiveMessage(String id);

  /// Get sent messages
  Future<List<CommunicationMessage>> getSentMessages({
    int page = 1,
    int limit = 20,
  });

  /// Get received messages
  Future<List<CommunicationMessage>> getReceivedMessages({
    int page = 1,
    int limit = 20,
  });

  /// Get draft messages
  Future<List<CommunicationMessage>> getDraftMessages({
    int page = 1,
    int limit = 20,
  });

  /// Get archived messages
  Future<List<CommunicationMessage>> getArchivedMessages({
    int page = 1,
    int limit = 20,
  });

  /// Get message statistics
  Future<Map<String, int>> getMessageStatistics();

  /// Get unread message count
  Future<int> getUnreadCount();

  /// Search messages
  Future<List<CommunicationMessage>> searchMessages({
    required String query,
    CommunicationTab? tab,
    int page = 1,
    int limit = 20,
  });
}
