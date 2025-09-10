/// Communication tab enumeration for shared use across all user roles
enum CommunicationTab { all, sent, receive, requests, drafts, archived }

/// Extension methods for CommunicationTab
extension CommunicationTabExtension on CommunicationTab {
  /// Get display name for the tab
  String get displayName {
    switch (this) {
      case CommunicationTab.all:
        return 'All';
      case CommunicationTab.sent:
        return 'Sent';
      case CommunicationTab.receive:
        return 'Receive';
      case CommunicationTab.requests:
        return 'Requests';
      case CommunicationTab.drafts:
        return 'Drafts';
      case CommunicationTab.archived:
        return 'Archived';
    }
  }

  /// Get icon for the tab
  String get iconName {
    switch (this) {
      case CommunicationTab.all:
        return 'inbox';
      case CommunicationTab.sent:
        return 'send';
      case CommunicationTab.receive:
        return 'inbox';
      case CommunicationTab.requests:
        return 'request_quote';
      case CommunicationTab.drafts:
        return 'drafts';
      case CommunicationTab.archived:
        return 'archive';
    }
  }
}
