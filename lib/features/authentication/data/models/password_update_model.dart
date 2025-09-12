import 'package:json_annotation/json_annotation.dart';

part 'password_update_model.g.dart';

@JsonSerializable(explicitToJson: true)
class PasswordUpdateModel {
  final String currentPassword;
  final String newPassword;
  final String confirmPassword;

  const PasswordUpdateModel({
    required this.currentPassword,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory PasswordUpdateModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordUpdateModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordUpdateModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ForgotPasswordModel {
  final String email;

  const ForgotPasswordModel({required this.email});

  factory ForgotPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ForgotPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ForgotPasswordModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class ResetPasswordModel {
  final String email;
  final String otp;
  final String newPassword;
  final String confirmPassword;

  const ResetPasswordModel({
    required this.email,
    required this.otp,
    required this.newPassword,
    required this.confirmPassword,
  });

  factory ResetPasswordModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class PasswordResponseModel {
  final bool success;
  final String message;

  const PasswordResponseModel({required this.success, required this.message});

  factory PasswordResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PasswordResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PasswordResponseModelToJson(this);
}

