import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_session.freezed.dart';
part 'user_session.g.dart';

@freezed
abstract class UserSession with _$UserSession {
  const factory UserSession({
    required String userId,
    @Default(false) bool isAuthenticated,
    DateTime? loginTime,
  }) = _UserSession;

  factory UserSession.fromJson(Map<String, dynamic> json) =>
      _$UserSessionFromJson(json);
}
