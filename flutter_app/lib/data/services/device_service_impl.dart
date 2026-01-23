import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import '../../domain/entities/image_capture.dart';
import '../../domain/entities/scan_result.dart';
import '../../domain/services/device_service.dart';

class DeviceServiceImpl implements DeviceService {
  final ImagePicker _picker = ImagePicker();

  @override
  Future<ImageCapture> captureImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if (image == null) {
      // It's better to throw an exception or handle it gracefully in the UI layer.
      // Assuming UI handles try-catch.
      throw Exception('Image capture cancelled');
    }

    final bytes = await image.readAsBytes();
    final base64String = base64Encode(bytes);

    return ImageCapture(
      imageData: base64String,
      mimeType: image.mimeType ?? 'image/jpeg',
      timestamp: DateTime.now(),
    );
  }

  @override
  Future<ScanResult> scanBarcode() async {
    // Mocking the scan result as per instructions
    await Future.delayed(const Duration(milliseconds: 1000));
    return ScanResult(
      code: "MOCK-SCAN-123",
      format: "QR_CODE",
      timestamp: DateTime.now(),
    );
  }
}
