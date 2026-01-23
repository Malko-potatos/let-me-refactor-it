// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scan_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ScanResult _$ScanResultFromJson(Map<String, dynamic> json) => _ScanResult(
  code: json['code'] as String,
  format: json['format'] as String?,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$ScanResultToJson(_ScanResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'format': instance.format,
      'timestamp': instance.timestamp.toIso8601String(),
    };
