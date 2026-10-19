import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';

/// Widget reusable untuk menampilkan ringkasan skor akhir kuis.
/// Berisi skor nilai persentase besar, serta statistik jawaban benar, salah, dan total soal.
class ScoreCard extends StatelessWidget {
  final int score;
  final int correctCount;
  final int incorrectCount;
  final int totalQuestions;

  const ScoreCard({
    super.key,
    required this.score,
    required this.correctCount,
    required this.incorrectCount,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double cardPadding = Responsive.w(context, 0.05).clamp(16.0, 24.0);
    final double scoreFontSize = Responsive.sp(context, 0.12, min: 42.0, max: 58.0);

    return Card(
      elevation: isDark ? 0 : 3,
      shadowColor: AppColors.primary.withValues(alpha: 0.12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: cardPadding, vertical: cardPadding * 1.1),
        child: Column(
          children: [
            // Label Skor Akhir
            Text(
              AppStrings.totalScoreLabel.toUpperCase(),
              style: TextStyle(
                fontSize: Responsive.sp(context, 0.032, min: 11.0, max: 13.0),
                fontWeight: FontWeight.w700,
                letterSpacing: 1.2,
                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
              ),
            ),
            SizedBox(height: Responsive.h(context, 0.01)),

            // Tampilan Angka Skor
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '$score',
                  style: TextStyle(
                    fontSize: scoreFontSize,
                    fontWeight: FontWeight.w900,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  '/100',
                  style: TextStyle(
                    fontSize: scoreFontSize * 0.45,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.45),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.h(context, 0.02)),

            const Divider(height: 1),
            SizedBox(height: Responsive.h(context, 0.02)),

            // 3 Statistik: Benar, Salah, Total Soal
            Row(
              children: [
                // Kolom Jawaban Benar
                Expanded(
                  child: _buildStatItem(
                    context,
                    label: AppStrings.correctAnswersLabel,
                    value: '$correctCount',
                    icon: Icons.check_circle_rounded,
                    color: AppColors.success,
                  ),
                ),
                Container(
                  height: 36,
                  width: 1,
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),

                // Kolom Jawaban Salah
                Expanded(
                  child: _buildStatItem(
                    context,
                    label: AppStrings.incorrectAnswersLabel,
                    value: '$incorrectCount',
                    icon: Icons.cancel_rounded,
                    color: AppColors.error,
                  ),
                ),
                Container(
                  height: 36,
                  width: 1,
                  color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                ),

                // Kolom Total Soal
                Expanded(
                  child: _buildStatItem(
                    context,
                    label: 'Total Soal',
                    value: '$totalQuestions',
                    icon: Icons.quiz_rounded,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  /// Helper untuk membangun satu blok statistik
  Widget _buildStatItem(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, size: 20, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: Responsive.sp(context, 0.045, min: 16.0, max: 20.0),
            fontWeight: FontWeight.w800,
            color: color,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: Responsive.sp(context, 0.026, min: 10.0, max: 12.0),
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
