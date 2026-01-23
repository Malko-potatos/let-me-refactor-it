import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:confetti/confetti.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

class BarcodeScannerScreen extends ConsumerStatefulWidget {
  final Function(String) onBarcodeDetected;

  const BarcodeScannerScreen({
    super.key,
    required this.onBarcodeDetected,
  });

  @override
  ConsumerState<BarcodeScannerScreen> createState() =>
      _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends ConsumerState<BarcodeScannerScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _scanLineAnimation;
  late Animation<double> _scanLineValue;
  bool _isScanning = true;
  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  @override
  void initState() {
    super.initState();
    _scanLineAnimation = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    )..repeat();
    _scanLineValue = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _scanLineAnimation,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _scanLineAnimation.dispose();
    _confettiController.dispose();
    super.dispose();
  }

  void _onBarcodeDetected(BarcodeCapture capture) {
    if (!_isScanning) return;

    final barcode = capture.barcodes.firstOrNull;
    if (barcode != null && barcode.rawValue != null) {
      _handleSuccessfulScan(barcode.rawValue!);
    }
  }

  void _handleSuccessfulScan(String barcodeValue) {
    setState(() => _isScanning = false);
    _scanLineAnimation.stop();

    HapticFeedback.mediumImpact();
    _confettiController.play();

    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        widget.onBarcodeDetected(barcodeValue);
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        fit: StackFit.expand,
        children: [
          _buildScanner(),
          _buildScanLine(),
          _buildInstruction(),
          _buildCloseButton(),
          _buildConfetti(),
        ],
      ),
    );
  }

  Widget _buildScanner() {
    return MobileScanner(
      onDetect: _onBarcodeDetected,
      controller: MobileScannerController(),
    );
  }

  Widget _buildScanLine() {
    return AnimatedBuilder(
      animation: _scanLineValue,
      builder: (context, child) {
        return Positioned.fill(
          child: Center(
            child: Container(
              width: 280,
              height: 2,
              margin: EdgeInsets.only(
                top: -140 + (280 * _scanLineValue.value),
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.secondary.withOpacity(0),
                    AppColors.secondary,
                    AppColors.secondary.withOpacity(0),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildInstruction() {
    return Positioned(
      top: 100,
      left: 20,
      right: 20,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.spacingM,
            vertical: AppConstants.spacingS,
          ),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.6),
            borderRadius: BorderRadius.circular(AppConstants.radiusM),
          ),
          child: Text(
            'Position barcode within frame',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                ),
            textAlign: TextAlign.center,
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

  Widget _buildConfetti() {
    return Positioned.fill(
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        colors: const [
          AppColors.secondary,
          AppColors.success,
          AppColors.warning,
          Colors.white,
        ],
        createParticlePath: (size) {
          final path = Path();
          path.addOval(Rect.fromCircle(
              center: const Offset(0, 0), radius: size.width / 2));
          return path;
        },
      ),
    );
  }
}
