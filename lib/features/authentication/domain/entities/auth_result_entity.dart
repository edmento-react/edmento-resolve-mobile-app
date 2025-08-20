import 'package:equatable/equatable.dart';

import 'user_entity.dart';

class AuthResult extends Equatable {
  final User user;
  final String sessionId;
  final String? refreshToken;

  const AuthResult({
    required this.user,
    required this.sessionId,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [user, sessionId, refreshToken];
}
