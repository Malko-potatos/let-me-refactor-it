import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/image_capture.dart';
import '../../domain/entities/scan_result.dart';
import 'repository_providers.dart';

class DeviceState {
  final List<ImageCapture> capturedImages;
  final ScanResult? lastScanResult;
  final bool isCameraLoading;
  final bool isScannerLoading;

  const DeviceState({
    this.capturedImages = const [],
    this.lastScanResult,
    this.isCameraLoading = false,
    this.isScannerLoading = false,
  });

  DeviceState copyWith({
    List<ImageCapture>? capturedImages,
    ScanResult? lastScanResult,
    bool? isCameraLoading,
    bool? isScannerLoading,
  }) {
    return DeviceState(
      capturedImages: capturedImages ?? this.capturedImages,
      // If lastScanResult is passed as null, it means we want to clear it?
      // Or just not update it?
      // Standard copyWith ignores nulls. To clear, we need a sentinel or explicit method.
      // For now, assume we just overwrite if provided, or keep existing.
      // But wait, ScanResult is nullable. passing null usually means "keep existing".
      // I'll stick to standard behavior: if null passed, keep existing.
      // Ideally use Freezed for this but I can't generate code right now easily.
      lastScanResult: lastScanResult ?? this.lastScanResult,
      isCameraLoading: isCameraLoading ?? this.isCameraLoading,
      isScannerLoading: isScannerLoading ?? this.isScannerLoading,
    );
  }
}

class DeviceNotifier extends Notifier<DeviceState> {
  @override
  DeviceState build() {
    return const DeviceState();
  }

  Future<void> captureImage() async {
    state = state.copyWith(isCameraLoading: true);
    try {
      final service = ref.read(deviceServiceProvider);
      final image = await service.captureImage();
      state = state.copyWith(
        capturedImages: [...state.capturedImages, image],
        isCameraLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isCameraLoading: false);
    }
  }

  Future<void> scanBarcode() async {
    state = state.copyWith(isScannerLoading: true);
    try {
      final service = ref.read(deviceServiceProvider);
      final result = await service.scanBarcode();
      // To properly update nullable lastScanResult, we need to manually construct
      // since my copyWith is simple.
      state = DeviceState(
        capturedImages: state.capturedImages,
        lastScanResult: result,
        isCameraLoading: state.isCameraLoading,
        isScannerLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isScannerLoading: false);
    }
  }
}

final deviceProvider = NotifierProvider<DeviceNotifier, DeviceState>(
  DeviceNotifier.new,
);
