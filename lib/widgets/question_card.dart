import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';

/// Widget reusable untuk menampilkan kartu pertanyaan kuis.
/// Berisi nomor soal, kategori/topik, serta teks pertanyaan dengan ukuran responsif.
class QuestionCard extends StatelessWidget {
  final int questionNumber;
  final int totalQuestions;
  final String questionText;
  final String category;

  const QuestionCard({
    super.key,
    required this.questionNumber,
    required this.totalQuestions,
    required this.questionText,
    this.category = 'Pemrograman Mobile',
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final double cardPadding = Responsive.w(context, 0.05).clamp(16.0, 22.0);
    final double questionFontSize = Responsive.sp(context, 0.043, min: 15.0, max: 18.0);

    return Card(
      elevation: isDark ? 0 : 2,
      shadowColor: AppColors.primary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
          width: 1.2,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row Header: Badge Topik & Indikator Nomor Soal
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Badge Kategori Topik
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: Responsive.w(context, 0.028).clamp(10.0, 14.0),
                    vertical: Responsive.h(context, 0.006).clamp(4.0, 6.0),
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: AppColors.primary.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.flutter_dash_rounded,
                        size: 14,
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        category,
                        style: TextStyle(
                          fontSize: Responsive.sp(context, 0.028, min: 11.0, max: 12.0),
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Nomor Soal Tag
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: isDark ? AppColors.darkBackground : const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '#$questionNumber',
                    style: TextStyle(
                      fontSize: Responsive.sp(context, 0.03, min: 11.0, max: 13.0),
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppColors.darkTextSecondary : AppColors.lightTextSecondary,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: Responsive.h(context, 0.02)),

            // Teks Pertanyaan
            Text(
              questionText,
              style: TextStyle(
                fontSize: questionFontSize,
                fontWeight: FontWeight.w600,
                height: 1.45,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
