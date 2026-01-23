// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'image_capture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ImageCapture {

 String get imageData;// base64
 String get mimeType; DateTime get timestamp;
/// Create a copy of ImageCapture
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ImageCaptureCopyWith<ImageCapture> get copyWith => _$ImageCaptureCopyWithImpl<ImageCapture>(this as ImageCapture, _$identity);

  /// Serializes this ImageCapture to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ImageCapture&&(identical(other.imageData, imageData) || other.imageData == imageData)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageData,mimeType,timestamp);

@override
String toString() {
  return 'ImageCapture(imageData: $imageData, mimeType: $mimeType, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $ImageCaptureCopyWith<$Res>  {
  factory $ImageCaptureCopyWith(ImageCapture value, $Res Function(ImageCapture) _then) = _$ImageCaptureCopyWithImpl;
@useResult
$Res call({
 String imageData, String mimeType, DateTime timestamp
});




}
/// @nodoc
class _$ImageCaptureCopyWithImpl<$Res>
    implements $ImageCaptureCopyWith<$Res> {
  _$ImageCaptureCopyWithImpl(this._self, this._then);

  final ImageCapture _self;
  final $Res Function(ImageCapture) _then;

/// Create a copy of ImageCapture
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? imageData = null,Object? mimeType = null,Object? timestamp = null,}) {
  return _then(_self.copyWith(
imageData: null == imageData ? _self.imageData : imageData // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// Adds pattern-matching-related methods to [ImageCapture].
extension ImageCapturePatterns on ImageCapture {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ImageCapture value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ImageCapture() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ImageCapture value)  $default,){
final _that = this;
switch (_that) {
case _ImageCapture():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ImageCapture value)?  $default,){
final _that = this;
switch (_that) {
case _ImageCapture() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String imageData,  String mimeType,  DateTime timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ImageCapture() when $default != null:
return $default(_that.imageData,_that.mimeType,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String imageData,  String mimeType,  DateTime timestamp)  $default,) {final _that = this;
switch (_that) {
case _ImageCapture():
return $default(_that.imageData,_that.mimeType,_that.timestamp);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String imageData,  String mimeType,  DateTime timestamp)?  $default,) {final _that = this;
switch (_that) {
case _ImageCapture() when $default != null:
return $default(_that.imageData,_that.mimeType,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ImageCapture implements ImageCapture {
  const _ImageCapture({required this.imageData, this.mimeType = 'image/png', required this.timestamp});
  factory _ImageCapture.fromJson(Map<String, dynamic> json) => _$ImageCaptureFromJson(json);

@override final  String imageData;
// base64
@override@JsonKey() final  String mimeType;
@override final  DateTime timestamp;

/// Create a copy of ImageCapture
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ImageCaptureCopyWith<_ImageCapture> get copyWith => __$ImageCaptureCopyWithImpl<_ImageCapture>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ImageCaptureToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ImageCapture&&(identical(other.imageData, imageData) || other.imageData == imageData)&&(identical(other.mimeType, mimeType) || other.mimeType == mimeType)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,imageData,mimeType,timestamp);

@override
String toString() {
  return 'ImageCapture(imageData: $imageData, mimeType: $mimeType, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$ImageCaptureCopyWith<$Res> implements $ImageCaptureCopyWith<$Res> {
  factory _$ImageCaptureCopyWith(_ImageCapture value, $Res Function(_ImageCapture) _then) = __$ImageCaptureCopyWithImpl;
@override @useResult
$Res call({
 String imageData, String mimeType, DateTime timestamp
});




}
/// @nodoc
class __$ImageCaptureCopyWithImpl<$Res>
    implements _$ImageCaptureCopyWith<$Res> {
  __$ImageCaptureCopyWithImpl(this._self, this._then);

  final _ImageCapture _self;
  final $Res Function(_ImageCapture) _then;

/// Create a copy of ImageCapture
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? imageData = null,Object? mimeType = null,Object? timestamp = null,}) {
  return _then(_ImageCapture(
imageData: null == imageData ? _self.imageData : imageData // ignore: cast_nullable_to_non_nullable
as String,mimeType: null == mimeType ? _self.mimeType : mimeType // ignore: cast_nullable_to_non_nullable
as String,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
