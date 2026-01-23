// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_session.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserSession {

 String get userId; bool get isAuthenticated; DateTime? get loginTime;
/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserSessionCopyWith<UserSession> get copyWith => _$UserSessionCopyWithImpl<UserSession>(this as UserSession, _$identity);

  /// Serializes this UserSession to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserSession&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated)&&(identical(other.loginTime, loginTime) || other.loginTime == loginTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,isAuthenticated,loginTime);

@override
String toString() {
  return 'UserSession(userId: $userId, isAuthenticated: $isAuthenticated, loginTime: $loginTime)';
}


}

/// @nodoc
abstract mixin class $UserSessionCopyWith<$Res>  {
  factory $UserSessionCopyWith(UserSession value, $Res Function(UserSession) _then) = _$UserSessionCopyWithImpl;
@useResult
$Res call({
 String userId, bool isAuthenticated, DateTime? loginTime
});




}
/// @nodoc
class _$UserSessionCopyWithImpl<$Res>
    implements $UserSessionCopyWith<$Res> {
  _$UserSessionCopyWithImpl(this._self, this._then);

  final UserSession _self;
  final $Res Function(UserSession) _then;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? isAuthenticated = null,Object? loginTime = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,loginTime: freezed == loginTime ? _self.loginTime : loginTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserSession].
extension UserSessionPatterns on UserSession {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserSession value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserSession() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserSession value)  $default,){
final _that = this;
switch (_that) {
case _UserSession():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserSession value)?  $default,){
final _that = this;
switch (_that) {
case _UserSession() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String userId,  bool isAuthenticated,  DateTime? loginTime)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserSession() when $default != null:
return $default(_that.userId,_that.isAuthenticated,_that.loginTime);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String userId,  bool isAuthenticated,  DateTime? loginTime)  $default,) {final _that = this;
switch (_that) {
case _UserSession():
return $default(_that.userId,_that.isAuthenticated,_that.loginTime);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String userId,  bool isAuthenticated,  DateTime? loginTime)?  $default,) {final _that = this;
switch (_that) {
case _UserSession() when $default != null:
return $default(_that.userId,_that.isAuthenticated,_that.loginTime);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserSession implements UserSession {
  const _UserSession({required this.userId, this.isAuthenticated = false, this.loginTime});
  factory _UserSession.fromJson(Map<String, dynamic> json) => _$UserSessionFromJson(json);

@override final  String userId;
@override@JsonKey() final  bool isAuthenticated;
@override final  DateTime? loginTime;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserSessionCopyWith<_UserSession> get copyWith => __$UserSessionCopyWithImpl<_UserSession>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserSessionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserSession&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.isAuthenticated, isAuthenticated) || other.isAuthenticated == isAuthenticated)&&(identical(other.loginTime, loginTime) || other.loginTime == loginTime));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,isAuthenticated,loginTime);

@override
String toString() {
  return 'UserSession(userId: $userId, isAuthenticated: $isAuthenticated, loginTime: $loginTime)';
}


}

/// @nodoc
abstract mixin class _$UserSessionCopyWith<$Res> implements $UserSessionCopyWith<$Res> {
  factory _$UserSessionCopyWith(_UserSession value, $Res Function(_UserSession) _then) = __$UserSessionCopyWithImpl;
@override @useResult
$Res call({
 String userId, bool isAuthenticated, DateTime? loginTime
});




}
/// @nodoc
class __$UserSessionCopyWithImpl<$Res>
    implements _$UserSessionCopyWith<$Res> {
  __$UserSessionCopyWithImpl(this._self, this._then);

  final _UserSession _self;
  final $Res Function(_UserSession) _then;

/// Create a copy of UserSession
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? isAuthenticated = null,Object? loginTime = freezed,}) {
  return _then(_UserSession(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,isAuthenticated: null == isAuthenticated ? _self.isAuthenticated : isAuthenticated // ignore: cast_nullable_to_non_nullable
as bool,loginTime: freezed == loginTime ? _self.loginTime : loginTime // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
