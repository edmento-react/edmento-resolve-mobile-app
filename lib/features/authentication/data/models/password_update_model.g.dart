// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'password_update_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PasswordUpdateModel _$PasswordUpdateModelFromJson(Map<String, dynamic> json) =>
    PasswordUpdateModel(
      currentPassword: json['currentPassword'] as String,
      newPassword: json['newPassword'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$PasswordUpdateModelToJson(
        PasswordUpdateModel instance) =>
    <String, dynamic>{
      'currentPassword': instance.currentPassword,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };

ForgotPasswordModel _$ForgotPasswordModelFromJson(Map<String, dynamic> json) =>
    ForgotPasswordModel(
      email: json['email'] as String,
    );

Map<String, dynamic> _$ForgotPasswordModelToJson(
        ForgotPasswordModel instance) =>
    <String, dynamic>{
      'email': instance.email,
    };

ResetPasswordModel _$ResetPasswordModelFromJson(Map<String, dynamic> json) =>
    ResetPasswordModel(
      email: json['email'] as String,
      otp: json['otp'] as String,
      newPassword: json['newPassword'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$ResetPasswordModelToJson(ResetPasswordModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'otp': instance.otp,
      'newPassword': instance.newPassword,
      'confirmPassword': instance.confirmPassword,
    };

PasswordResponseModel _$PasswordResponseModelFromJson(
        Map<String, dynamic> json) =>
    PasswordResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );

Map<String, dynamic> _$PasswordResponseModelToJson(
        PasswordResponseModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
    };
