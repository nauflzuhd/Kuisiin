import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

/// Widget reusable untuk menampilkan satu pilihan jawaban kuis.
/// Memiliki status visual [isSelected] (normal vs terpilih) dengan ukuran dinamis berbasis [Responsive].
class OptionTile extends StatelessWidget {
  final String optionLabel; // Contoh: 'A', 'B', 'C', 'D'
  final String optionText;
  final bool isSelected;
  final VoidCallback onTap;

  const OptionTile({
    super.key,
    required this.optionLabel,
    required this.optionText,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double badgeSize = Responsive.w(context, 0.085).clamp(32.0, 38.0);
    final double fontSize = Responsive.sp(context, 0.037, min: 13.0, max: 15.0);

    // Warna dinamis berdasarkan status terpilih dan tema aktif
    final Color backgroundColor = isSelected
        ? (isDark
              ? AppColors.primaryDark.withValues(alpha: 0.35)
              : AppColors.primary.withValues(alpha: 0.08))
        : (isDark ? AppColors.darkSurface : AppColors.lightSurface);

    final Color borderColor = isSelected
        ? AppColors.primary
        : (isDark ? AppColors.darkBorder : AppColors.lightBorder);

    final Color badgeBgColor = isSelected
        ? AppColors.primary
        : (isDark ? AppColors.darkBackground : const Color(0xFFF1F5F9));

    final Color badgeTextColor = isSelected
        ? Colors.white
        : (isDark ? AppColors.darkTextPrimary : AppColors.lightTextPrimary);

    return Padding(
      padding: EdgeInsets.only(
        bottom: Responsive.h(context, 0.015).clamp(10.0, 14.0),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          splashColor: AppColors.primary.withValues(alpha: 0.12),
          highlightColor: AppColors.primary.withValues(alpha: 0.06),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            padding: EdgeInsets.symmetric(
              horizontal: Responsive.w(context, 0.04).clamp(12.0, 16.0),
              vertical: Responsive.h(context, 0.016).clamp(12.0, 16.0),
            ),
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: borderColor,
                width: isSelected ? 2.0 : 1.2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: AppColors.primary.withValues(alpha: 0.18),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Row(
              children: [
                // Badge Label Opsi (A, B, C, D)
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: badgeSize,
                  height: badgeSize,
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : borderColor,
                      width: 1.2,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    optionLabel,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.w700,
                      color: badgeTextColor,
                    ),
                  ),
                ),
                SizedBox(width: Responsive.w(context, 0.035).clamp(10.0, 14.0)),

                // Teks Jawaban
                Expanded(
                  child: Text(
                    optionText,
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.w400,
                      color: isSelected
                          ? (isDark ? Colors.white : AppColors.primaryDark)
                          : Theme.of(context).colorScheme.onSurface,
                      height: 1.35,
                    ),
                  ),
                ),
                SizedBox(width: Responsive.w(context, 0.02).clamp(6.0, 10.0)),

                // Indikator Radio / Centang Terpilih
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    border: Border.all(
                      color: isSelected ? AppColors.primary : borderColor,
                      width: 1.5,
                    ),
                  ),
                  child: isSelected
                      ? const Icon(
                          Icons.check_rounded,
                          size: 15,
                          color: Colors.white,
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
