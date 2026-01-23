import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:camera/camera.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

class CameraScreen extends StatefulWidget {
  final Function(String) onPhotoCaptured;

  const CameraScreen({
    super.key,
    required this.onPhotoCaptured,
  });

  @override
  State<CameraScreen> createState() => _CameraScreenState();
}

class _CameraScreenState extends State<CameraScreen>
    with SingleTickerProviderStateMixin {
  CameraController? _controller;
  bool _isCapturing = false;
  late AnimationController _pulseAnimation;
  late Animation<double> _pulseAnimationValue;

  @override
  void initState() {
    super.initState();
    _pulseAnimation = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);
    _pulseAnimationValue = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(
        parent: _pulseAnimation,
        curve: Curves.easeInOut,
      ),
    );
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    if (cameras.isEmpty) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('No camera available')),
        );
        Navigator.of(context).pop();
      }
      return;
    }

    final camera = cameras.first;
    _controller = CameraController(
      camera,
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await _controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Camera error: $e')),
        );
        Navigator.of(context).pop();
      }
    }
  }

  @override
  void dispose() {
    _pulseAnimation.dispose();
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _takePhoto() async {
    if (_controller == null ||
        !_controller!.value.isInitialized ||
        _isCapturing) {
      return;
    }

    setState(() => _isCapturing = true);
    HapticFeedback.heavyImpact();

    try {
      await Future.delayed(const Duration(milliseconds: 100));
      final image = await _controller!.takePicture();

      if (mounted) {
        widget.onPhotoCaptured(image.path);
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to capture photo: $e')),
        );
      }
      setState(() => _isCapturing = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _controller == null || !_controller!.value.isInitialized
          ? const Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            )
          : Stack(
              fit: StackFit.expand,
              children: [
                _buildCameraPreview(),
                _buildCaptureFrame(),
                _buildCaptureButton(),
                _buildCloseButton(),
              ],
            ),
    );
  }

  Widget _buildCameraPreview() {
    return Positioned.fill(
      child: FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          width: _controller!.value.previewSize!.height,
          height: _controller!.value.previewSize!.width,
          child: CameraPreview(_controller!),
        ),
      ),
    );
  }

  Widget _buildCaptureFrame() {
    return AnimatedBuilder(
      animation: _pulseAnimationValue,
      builder: (context, child) {
        return Positioned.fill(
          child: Center(
            child: Transform.scale(
              scale: _pulseAnimationValue.value,
              child: Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.white.withOpacity(0.5),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildCaptureButton() {
    return Positioned(
      bottom: 40,
      left: 0,
      right: 0,
      child: Center(
        child: GestureDetector(
          onTap: _isCapturing ? null : _takePhoto,
          child: Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _isCapturing ? Colors.grey : Colors.white,
              border: Border.all(
                color: Colors.white,
                width: 4,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Positioned(
      top: 40,
      right: 20,
      child: IconButton(
        icon: const Icon(
          Icons.close,
          color: Colors.white,
          size: 32,
        ),
        onPressed: () => Navigator.of(context).pop(),
      ),
    );
  }
}
