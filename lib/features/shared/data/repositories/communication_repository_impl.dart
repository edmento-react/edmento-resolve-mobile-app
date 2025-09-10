import 'package:edmentoresolve/features/shared/data/datasources/communication_remote_data_source.dart';
import 'package:edmentoresolve/features/shared/data/models/communication_message_model.dart';
import 'package:edmentoresolve/features/shared/domain/entities/communication_message.dart';
import 'package:edmentoresolve/features/shared/domain/enums/communication_tab.dart';
import 'package:edmentoresolve/features/shared/domain/repositories/communication_repository.dart';

/// Implementation of communication repository - shared across all user roles
class CommunicationRepositoryImpl implements ICommunicationRepository {
  final ICommunicationRemoteDataSource _remoteDataSource;

  const CommunicationRepositoryImpl({
    required ICommunicationRemoteDataSource remoteDataSource,
  }) : _remoteDataSource = remoteDataSource;

  @override
  Future<List<CommunicationMessage>> getMessages({
    required CommunicationTab tab,
    int page = 1,
    int limit = 20,
    String? searchQuery,
  }) async {
    try {
      final messageModels = await _remoteDataSource.getMessages(
        tab: tab,
        page: page,
        limit: limit,
        searchQuery: searchQuery,
      );
      return messageModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get messages: $e');
    }
  }

  @override
  Future<CommunicationMessage?> getMessageById(String id) async {
    try {
      final messageModel = await _remoteDataSource.getMessageById(id);
      return messageModel?.toEntity();
    } catch (e) {
      throw Exception('Failed to get message by id: $e');
    }
  }

  @override
  Future<CommunicationMessage> sendMessage(CommunicationMessage message) async {
    try {
      final messageModel = CommunicationMessageModel.fromEntity(message);
      final sentMessageModel = await _remoteDataSource.sendMessage(
        messageModel,
      );
      return sentMessageModel.toEntity();
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  @override
  Future<CommunicationMessage> saveDraft(CommunicationMessage message) async {
    try {
      final messageModel = CommunicationMessageModel.fromEntity(message);
      final savedMessageModel = await _remoteDataSource.saveDraft(messageModel);
      return savedMessageModel.toEntity();
    } catch (e) {
      throw Exception('Failed to save draft: $e');
    }
  }

  @override
  Future<CommunicationMessage> updateMessage(
    CommunicationMessage message,
  ) async {
    try {
      final messageModel = CommunicationMessageModel.fromEntity(message);
      final updatedMessageModel = await _remoteDataSource.updateMessage(
        messageModel,
      );
      return updatedMessageModel.toEntity();
    } catch (e) {
      throw Exception('Failed to update message: $e');
    }
  }

  @override
  Future<void> deleteMessage(String id) async {
    try {
      await _remoteDataSource.deleteMessage(id);
    } catch (e) {
      throw Exception('Failed to delete message: $e');
    }
  }

  @override
  Future<void> markAsRead(String id) async {
    try {
      await _remoteDataSource.markAsRead(id);
    } catch (e) {
      throw Exception('Failed to mark message as read: $e');
    }
  }

  @override
  Future<void> markAsUnread(String id) async {
    try {
      await _remoteDataSource.markAsUnread(id);
    } catch (e) {
      throw Exception('Failed to mark message as unread: $e');
    }
  }

  @override
  Future<void> archiveMessage(String id) async {
    try {
      await _remoteDataSource.archiveMessage(id);
    } catch (e) {
      throw Exception('Failed to archive message: $e');
    }
  }

  @override
  Future<void> unarchiveMessage(String id) async {
    try {
      await _remoteDataSource.unarchiveMessage(id);
    } catch (e) {
      throw Exception('Failed to unarchive message: $e');
    }
  }

  @override
  Future<List<CommunicationMessage>> getSentMessages({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final messageModels = await _remoteDataSource.getSentMessages(
        page: page,
        limit: limit,
      );
      return messageModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get sent messages: $e');
    }
  }

  @override
  Future<List<CommunicationMessage>> getReceivedMessages({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final messageModels = await _remoteDataSource.getReceivedMessages(
        page: page,
        limit: limit,
      );
      return messageModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get received messages: $e');
    }
  }

  @override
  Future<List<CommunicationMessage>> getDraftMessages({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final messageModels = await _remoteDataSource.getDraftMessages(
        page: page,
        limit: limit,
      );
      return messageModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get draft messages: $e');
    }
  }

  @override
  Future<List<CommunicationMessage>> getArchivedMessages({
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final messageModels = await _remoteDataSource.getArchivedMessages(
        page: page,
        limit: limit,
      );
      return messageModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to get archived messages: $e');
    }
  }

  @override
  Future<Map<String, int>> getMessageStatistics() async {
    try {
      return await _remoteDataSource.getMessageStatistics();
    } catch (e) {
      throw Exception('Failed to get message statistics: $e');
    }
  }

  @override
  Future<int> getUnreadCount() async {
    try {
      return await _remoteDataSource.getUnreadCount();
    } catch (e) {
      throw Exception('Failed to get unread count: $e');
    }
  }

  @override
  Future<List<CommunicationMessage>> searchMessages({
    required String query,
    CommunicationTab? tab,
    int page = 1,
    int limit = 20,
  }) async {
    try {
      final messageModels = await _remoteDataSource.searchMessages(
        query: query,
        tab: tab,
        page: page,
        limit: limit,
      );
      return messageModels.map((model) => model.toEntity()).toList();
    } catch (e) {
      throw Exception('Failed to search messages: $e');
    }
  }
}
