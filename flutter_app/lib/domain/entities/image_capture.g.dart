// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_capture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ImageCapture _$ImageCaptureFromJson(Map<String, dynamic> json) =>
    _ImageCapture(
      imageData: json['imageData'] as String,
      mimeType: json['mimeType'] as String? ?? 'image/png',
      timestamp: DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$ImageCaptureToJson(_ImageCapture instance) =>
    <String, dynamic>{
      'imageData': instance.imageData,
      'mimeType': instance.mimeType,
      'timestamp': instance.timestamp.toIso8601String(),
    };
