import 'package:flutter/material.dart';

import '../core/constants/app_colors.dart';
import '../core/utils/responsive.dart';
import '../models/question.dart';
import '../providers/quiz_provider.dart';

/// Modal Bottom Sheet reusable untuk meninjau seluruh pertanyaan kuis,
/// jawaban yang dipilih pengguna, kunci jawaban yang benar, serta penjelasan (pembahasan).
class ReviewAnswersSheet extends StatelessWidget {
  final QuizProvider quiz;

  const ReviewAnswersSheet({super.key, required this.quiz});

  /// Fungsi statis pembantu untuk menampilkan bottom sheet review jawaban
  static void show(BuildContext context, QuizProvider quiz) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewAnswersSheet(quiz: quiz),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final List<Question> questions = quiz.questions;
    final List<int?> userAnswers = quiz.selectedAnswers;
    final double sheetHeight = Responsive.h(context, 0.88).clamp(520.0, 780.0);
    final double horizontalPadding = Responsive.w(context, 0.05).clamp(16.0, 24.0);

    return Container(
      height: sheetHeight,
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 16,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Drag handle bar
          Center(
            child: Container(
              margin: const EdgeInsets.only(top: 12, bottom: 8),
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),

          // Header sheet
          Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(
                      Icons.fact_check_rounded,
                      color: AppColors.primary,
                      size: 24,
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Pembahasan & Evaluasi',
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 0.042, min: 16.0, max: 18.0),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          'Benar ${quiz.correctCount} dari ${quiz.totalQuestions} soal',
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 0.03, min: 11.0, max: 13.0),
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withValues(alpha: 0.65),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  tooltip: 'Tutup',
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // Daftar pertanyaan dan pembahasan
          Expanded(
            child: ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 16),
              itemCount: questions.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final Question question = questions[index];
                final int? selectedOptionIndex = userAnswers[index];
                final bool isAnswered = selectedOptionIndex != null;
                final bool isCorrect = isAnswered && selectedOptionIndex == question.correctIndex;

                return Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                    side: BorderSide(
                      color: isCorrect
                          ? AppColors.success.withValues(alpha: 0.4)
                          : (isAnswered
                              ? AppColors.error.withValues(alpha: 0.4)
                              : (isDark ? AppColors.darkBorder : AppColors.lightBorder)),
                      width: 1.2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Tag Status Soal & Nomor
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Soal #${index + 1}',
                              style: TextStyle(
                                fontSize: Responsive.sp(context, 0.03, min: 12.0, max: 13.0),
                                fontWeight: FontWeight.w700,
                                color: AppColors.primary,
                              ),
                            ),
                            _buildStatusBadge(isAnswered, isCorrect),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // Teks Pertanyaan
                        Text(
                          question.questionText,
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 0.036, min: 13.0, max: 15.0),
                            fontWeight: FontWeight.w600,
                            height: 1.35,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Rincian Jawaban Pengguna
                        if (isAnswered) ...[
                          _buildAnswerRow(
                            label: 'Jawaban Kamu:',
                            value: question.options[selectedOptionIndex],
                            isCorrect: isCorrect,
                          ),
                        ] else ...[
                          _buildAnswerRow(
                            label: 'Jawaban Kamu:',
                            value: 'Tidak Dijawab',
                            isCorrect: false,
                            isUnanswered: true,
                          ),
                        ],

                        // Jika salah atau tidak dijawab, tampilkan kunci jawaban benar
                        if (!isCorrect) ...[
                          const SizedBox(height: 6),
                          _buildAnswerRow(
                            label: 'Kunci Jawaban:',
                            value: question.options[question.correctIndex],
                            isCorrect: true,
                          ),
                        ],

                        // Kotak Penjelasan / Pembahasan
                        if (question.explanation != null &&
                            question.explanation!.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.08),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.2),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Icon(
                                  Icons.lightbulb_outline_rounded,
                                  size: 18,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Pembahasan:',
                                        style: TextStyle(
                                          fontSize: Responsive.sp(context, 0.028, min: 11.0, max: 12.0),
                                          fontWeight: FontWeight.w700,
                                          color: AppColors.primary,
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        question.explanation!,
                                        style: TextStyle(
                                          fontSize: Responsive.sp(context, 0.03, min: 12.0, max: 13.0),
                                          height: 1.35,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Badge status benar / salah / tidak dijawab
  Widget _buildStatusBadge(bool isAnswered, bool isCorrect) {
    if (!isAnswered) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.grey.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Text(
          'Tidak Dijawab',
          style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: Colors.grey),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: isCorrect
            ? AppColors.success.withValues(alpha: 0.15)
            : AppColors.error.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            isCorrect ? Icons.check_circle_rounded : Icons.cancel_rounded,
            size: 13,
            color: isCorrect ? AppColors.success : AppColors.error,
          ),
          const SizedBox(width: 4),
          Text(
            isCorrect ? 'Benar' : 'Salah',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: isCorrect ? AppColors.success : AppColors.error,
            ),
          ),
        ],
      ),
    );
  }

  /// Baris tampilan teks pilihan jawaban
  Widget _buildAnswerRow({
    required String label,
    required String value,
    required bool isCorrect,
    bool isUnanswered = false,
  }) {
    final Color color = isUnanswered
        ? Colors.grey
        : (isCorrect ? AppColors.success : AppColors.error);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 110,
          child: Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Colors.grey,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}
