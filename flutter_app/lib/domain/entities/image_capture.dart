import 'package:freezed_annotation/freezed_annotation.dart';

part 'image_capture.freezed.dart';
part 'image_capture.g.dart';

@freezed
abstract class ImageCapture with _$ImageCapture {
  const factory ImageCapture({
    required String imageData, // base64
    @Default('image/png') String mimeType,
    required DateTime timestamp,
  }) = _ImageCapture;

  factory ImageCapture.fromJson(Map<String, dynamic> json) =>
      _$ImageCaptureFromJson(json);
}
