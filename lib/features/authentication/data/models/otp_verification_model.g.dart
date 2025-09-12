// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'otp_verification_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OtpVerificationModel _$OtpVerificationModelFromJson(
        Map<String, dynamic> json) =>
    OtpVerificationModel(
      email: json['email'] as String,
      otp: json['otp'] as String,
    );

Map<String, dynamic> _$OtpVerificationModelToJson(
        OtpVerificationModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
    };

OtpVerificationResponseModel _$OtpVerificationResponseModelFromJson(
        Map<String, dynamic> json) =>
    OtpVerificationResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$OtpVerificationResponseModelToJson(
        OtpVerificationResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'token': instance.token,
    };
