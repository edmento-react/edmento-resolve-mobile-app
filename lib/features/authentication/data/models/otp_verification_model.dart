import 'package:json_annotation/json_annotation.dart';

part 'otp_verification_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OtpVerificationModel {
  final String email;
  final String otp;

  const OtpVerificationModel({required this.email, required this.otp});

  factory OtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerificationModelToJson(this);
}

@JsonSerializable(explicitToJson: true)
class OtpVerificationResponseModel {
  final bool success;
  final String message;
  final String? token;

  const OtpVerificationResponseModel({
    required this.success,
    required this.message,
    this.token,
  });

  factory OtpVerificationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$OtpVerificationResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$OtpVerificationResponseModelToJson(this);
}

