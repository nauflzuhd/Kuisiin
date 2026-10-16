import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

/// Widget reusable untuk menampilkan bilah progres pengerjaan kuis.
/// Menampilkan informasi teks "Soal X/Y", persentase pengerjaan, dan visual LinearProgressIndicator.
class QuizProgressBar extends StatelessWidget {
  final int current;
  final int total;

  const QuizProgressBar({
    super.key,
    required this.current,
    required this.total,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double progressValue = total > 0 ? (current / total).clamp(0.0, 1.0) : 0.0;
    final int progressPercent = (progressValue * 100).round();
    final double labelFontSize = Responsive.sp(context, 0.033, min: 12.0, max: 14.0);
    final double barHeight = Responsive.h(context, 0.01).clamp(7.0, 9.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Label teks progres dan persentase
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.assignment_outlined,
                  size: 16,
                  color: AppColors.primary,
                ),
                const SizedBox(width: 6),
                Text(
                  'Soal $current dari $total',
                  style: TextStyle(
                    fontSize: labelFontSize,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
            Text(
              '$progressPercent%',
              style: TextStyle(
                fontSize: labelFontSize,
                fontWeight: FontWeight.w700,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        SizedBox(height: Responsive.h(context, 0.01).clamp(6.0, 8.0)),

        // Linear Progress Bar dengan animasi halus
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: TweenAnimationBuilder<double>(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            tween: Tween<double>(begin: 0, end: progressValue),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value,
                minHeight: barHeight,
                backgroundColor: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primary),
              );
            },
          ),
        ),
      ],
    );
  }
}
