import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/haptics.dart';

enum ButtonVariant { primary, secondary, outline, ghost }

/// A production-ready button widget with built-in haptics, loading states, and custom variants.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonVariant variant;
  final bool isLoading;
  final Widget? icon;
  final double? width;
  final double height;
  final double borderRadius;
  final Color? customColor;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 52.0,
    this.borderRadius = 14.0,
    this.customColor,
  });

  void _handleTap() {
    if (onPressed == null || isLoading) return;
    AppHaptics.light();
    onPressed!();
  }

  @override
  Widget build(BuildContext context) {
    Color getBgColor() {
      if (onPressed == null && !isLoading) return const Color(0xFFCBD5E1);
      if (customColor != null) return customColor!;
      switch (variant) {
        case ButtonVariant.primary:
          return AppColors.primary;
        case ButtonVariant.secondary:
          return AppColors.primaryLight;
        case ButtonVariant.outline:
        case ButtonVariant.ghost:
          return Colors.transparent;
      }
    }

    Color getTextColor() {
      if (onPressed == null && !isLoading) return const Color(0xFF94A3B8);
      switch (variant) {
        case ButtonVariant.primary:
          return Colors.white;
        case ButtonVariant.secondary:
          return AppColors.primary;
        case ButtonVariant.outline:
          return customColor ?? AppColors.primary;
        case ButtonVariant.ghost:
          return AppColors.textPrimary;
      }
    }

    Border? getBorder() {
      if (variant == ButtonVariant.outline) {
        return Border.all(
          color: onPressed == null ? const Color(0xFFCBD5E1) : (customColor ?? AppColors.primary),
          width: 1.5,
        );
      }
      return null;
    }

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: Material(
        color: getBgColor(),
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: _handleTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              border: getBorder(),
            ),
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: isLoading
                ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        variant == ButtonVariant.primary ? Colors.white : AppColors.primary,
                      ),
                    ),
                  )
                : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (icon != null) ...[
                        icon!,
                        const SizedBox(width: 8),
                      ],
                      Text(
                        text,
                        style: TextStyle(
                          color: getTextColor(),
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.2,
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
