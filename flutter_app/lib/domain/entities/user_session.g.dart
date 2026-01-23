// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserSession _$UserSessionFromJson(Map<String, dynamic> json) => _UserSession(
  userId: json['userId'] as String,
  isAuthenticated: json['isAuthenticated'] as bool? ?? false,
  loginTime: json['loginTime'] == null
      ? null
      : DateTime.parse(json['loginTime'] as String),
);

Map<String, dynamic> _$UserSessionToJson(_UserSession instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'isAuthenticated': instance.isAuthenticated,
      'loginTime': instance.loginTime?.toIso8601String(),
    };
