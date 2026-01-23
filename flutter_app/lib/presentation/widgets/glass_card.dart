import 'dart:ui';
import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';

/// A glassmorphic card widget with blur effect
class GlassCard extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final BorderRadius? borderRadius;
  final Color? overlayColor;
  final VoidCallback? onLongPress;

  const GlassCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.borderRadius,
    this.overlayColor,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius =
        borderRadius ?? BorderRadius.circular(AppConstants.glassBorderRadius);
    final effectivePadding =
        padding ?? const EdgeInsets.all(AppConstants.spacingM);

    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: effectiveBorderRadius,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: effectiveBorderRadius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: AppConstants.glassBlurSigma,
            sigmaY: AppConstants.glassBlurSigma,
          ),
          child: GestureDetector(
            onTap: onTap,
            onLongPress: onLongPress,
            child: AnimatedContainer(
              duration: const Duration(
                  milliseconds: AppConstants.normalAnimationDuration),
              decoration: BoxDecoration(
                color: (overlayColor ?? AppColors.card),
                borderRadius: effectiveBorderRadius,
                border: Border.all(
                  color: AppColors.border,
                  width: 1,
                ),
              ),
              padding: effectivePadding,
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
