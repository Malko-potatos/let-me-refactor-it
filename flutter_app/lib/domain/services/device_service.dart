import '../entities/image_capture.dart';
import '../entities/scan_result.dart';

abstract class DeviceService {
  Future<ImageCapture> captureImage();
  Future<ScanResult> scanBarcode();
}
