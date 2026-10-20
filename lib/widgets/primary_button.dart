import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

/// Widget tombol utama yang reusable untuk seluruh aplikasi.
/// Dibuat sebagai StatelessWidget dengan ukuran dinamis berbasis [Responsive] helper.
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isLoading;
  final double? width;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isLoading = false,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight =
        height ?? Responsive.h(context, 0.065).clamp(48.0, 56.0);
    final double buttonWidth = width ?? double.infinity;
    final double fontSize = Responsive.sp(context, 0.04, min: 14.0, max: 16.0);

    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          disabledBackgroundColor: AppColors.primary.withValues(alpha: 0.5),
          elevation: 2,
          shadowColor: AppColors.primary.withValues(alpha: 0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: Responsive.w(context, 0.04).clamp(16.0, 24.0),
          ),
        ),
        child: isLoading
            ? SizedBox(
                width: Responsive.w(context, 0.05).clamp(20.0, 24.0),
                height: Responsive.w(context, 0.05).clamp(20.0, 24.0),
                child: const CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: fontSize * 1.25),
                    SizedBox(
                      width: Responsive.w(context, 0.02).clamp(6.0, 10.0),
                    ),
                  ],
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
