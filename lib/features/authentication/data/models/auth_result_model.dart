import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/auth_result_entity.dart';
import 'user_model.dart';

part 'auth_result_model.g.dart';

@JsonSerializable()
class AuthResultModel {
  final UserModel user;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? sessionId;
  @JsonKey(includeFromJson: false, includeToJson: false)
  final String? refreshToken;

  const AuthResultModel({
    required this.user,
    this.sessionId,
    this.refreshToken,
  });

  factory AuthResultModel.fromJson(Map<String, dynamic> json) =>
      _$AuthResultModelFromJson(json);

  /// Custom factory to inject sessionId from header
  factory AuthResultModel.fromJsonWithSessionId(
    Map<String, dynamic> json,
    String sessionId,
  ) {
    final model = AuthResultModel.fromJson(json);
    return AuthResultModel(
      user: model.user,
      sessionId: sessionId,
      refreshToken: model.refreshToken,
    );
  }

  Map<String, dynamic> toJson() => _$AuthResultModelToJson(this);

  factory AuthResultModel.fromEntity(AuthResult authResult) {
    // Debug: mapping entity to model
    return AuthResultModel(
      user: UserModel.fromEntity(authResult.user),
      sessionId: authResult.sessionId,
      refreshToken: authResult.refreshToken,
    );
  }

  AuthResult toEntity() {
    return AuthResult(
      user: user.toEntity(),
      sessionId: sessionId ?? "",
      refreshToken: refreshToken ?? '',
    );
  }
}
