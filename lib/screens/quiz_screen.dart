import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress_bar.dart';

/// Halaman Kuis (QuizScreen).
/// Menampilkan pertanyaan kuis dinamis dari [QuizProvider] menggunakan widget modular:
/// [QuizProgressBar], [QuestionCard], dan [OptionTile].
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  /// Label huruf untuk setiap pilihan jawaban (A, B, C, D)
  static const List<String> _optionLabels = ['A', 'B', 'C', 'D'];

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final currentQuestion = quiz.currentQuestion;
    final int questionNumber = quiz.currentIndex + 1;
    final int? selectedOption = quiz.currentAnswer;
    final double horizontalPadding = Responsive.w(context, 0.05).clamp(16.0, 28.0);
    final double verticalPadding = Responsive.h(context, 0.02).clamp(14.0, 24.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        automaticallyImplyLeading: false,
        actions: [
          // Tombol Keluar Kuis dengan konfirmasi
          IconButton(
            tooltip: 'Keluar Kuis',
            icon: const Icon(Icons.close_rounded),
            onPressed: () => _showExitConfirmationDialog(context, quiz),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // 1. Header Sapaan Pengguna
                  _buildUserHeader(context, quiz.userName),
                  SizedBox(height: Responsive.h(context, 0.02)),

                  // 2. Bilah Progres Kuis (QuizProgressBar)
                  QuizProgressBar(
                    current: questionNumber,
                    total: quiz.totalQuestions,
                  ),
                  SizedBox(height: Responsive.h(context, 0.025)),

                  // 3. Kartu Pertanyaan (QuestionCard)
                  QuestionCard(
                    questionNumber: questionNumber,
                    totalQuestions: quiz.totalQuestions,
                    questionText: currentQuestion.questionText,
                  ),
                  SizedBox(height: Responsive.h(context, 0.025)),

                  // 4. Daftar Pilihan Jawaban (OptionTile)
                  Text(
                    'Pilih satu jawaban yang paling tepat:',
                    style: TextStyle(
                      fontSize: Responsive.sp(context, 0.032, min: 12.0, max: 13.0),
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withValues(alpha: 0.65),
                    ),
                  ),
                  SizedBox(height: Responsive.h(context, 0.015)),

                  ...List.generate(currentQuestion.options.length, (index) {
                    final String label = index < _optionLabels.length
                        ? _optionLabels[index]
                        : '${index + 1}';
                    final String optionText = currentQuestion.options[index];
                    final bool isSelected = selectedOption == index;

                    return OptionTile(
                      optionLabel: label,
                      optionText: optionText,
                      isSelected: isSelected,
                      onTap: () {
                        quiz.selectAnswer(index);
                      },
                    );
                  }),
                  SizedBox(height: Responsive.h(context, 0.025)),

                  // 5. Tombol Navigasi Bawah (Sebelumnya & Selanjutnya / Selesai)
                  _buildBottomNavigation(context, quiz),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Membangun header sapaan nama pengguna
  Widget _buildUserHeader(BuildContext context, String userName) {
    final String displayName = userName.trim().isEmpty ? 'Peserta' : userName.trim();

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: Responsive.w(context, 0.045).clamp(16.0, 20.0),
              backgroundColor: AppColors.primary.withValues(alpha: 0.15),
              child: const Icon(
                Icons.person_rounded,
                size: 20,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Halo, $displayName! 👋',
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 0.04, min: 14.0, max: 16.0),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Semoga berhasil menjawab dengan benar!',
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 0.028, min: 10.0, max: 12.0),
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Membangun barisan tombol navigasi sebelumnya & berikutnya
  Widget _buildBottomNavigation(BuildContext context, QuizProvider quiz) {
    final bool isFirst = quiz.isFirstQuestion;
    final bool isLast = quiz.isLastQuestion;

    return Row(
      children: [
        // Tombol Sebelumnya
        if (!isFirst) ...[
          Expanded(
            flex: 1,
            child: SizedBox(
              height: Responsive.h(context, 0.065).clamp(48.0, 56.0),
              child: OutlinedButton.icon(
                onPressed: () => quiz.previous(),
                icon: const Icon(Icons.arrow_back_rounded, size: 18),
                label: const Text(AppStrings.previousButton),
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                  side: const BorderSide(color: AppColors.primary, width: 1.2),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
        ],

        // Tombol Selanjutnya atau Selesai
        Expanded(
          flex: isFirst ? 2 : 1,
          child: PrimaryButton(
            text: isLast ? AppStrings.finishButton : AppStrings.nextButton,
            icon: isLast ? Icons.check_circle_rounded : Icons.arrow_forward_rounded,
            onPressed: () {
              if (isLast) {
                quiz.finish();
                Navigator.pushReplacementNamed(context, AppRoutes.result);
              } else {
                quiz.next();
              }
            },
          ),
        ),
      ],
    );
  }

  /// Dialog konfirmasi jika pengguna ingin membatalkan kuis dan keluar ke beranda
  void _showExitConfirmationDialog(BuildContext context, QuizProvider quiz) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('Keluar dari Kuis?'),
          content: const Text(
            'Apakah kamu yakin ingin keluar? Progres kuis kamu saat ini akan direset.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext),
              child: const Text('Lanjutkan Kuis'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(dialogContext);
                quiz.reset(keepUserName: false);
                Navigator.pushNamedAndRemoveUntil(
                  context,
                  AppRoutes.welcome,
                  (route) => false,
                );
              },
              child: const Text('Keluar'),
            ),
          ],
        );
      },
    );
  }
}
