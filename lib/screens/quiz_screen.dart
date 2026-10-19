import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../models/question.dart';
import '../providers/quiz_provider.dart';
import '../widgets/option_tile.dart';
import '../widgets/primary_button.dart';
import '../widgets/question_card.dart';
import '../widgets/quiz_progress_bar.dart';

/// Halaman Kuis (QuizScreen).
/// Menampilkan pertanyaan kuis dinamis dari [QuizProvider] menggunakan widget modular:
/// [QuizProgressBar], [QuestionCard], dan [OptionTile].
/// Mendukung layout portrait (1 kolom) dan landscape (2 kolom adaptif).
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
    final bool isLandscape = Responsive.isLandscape(context);

    final double horizontalPadding = Responsive.w(context, 0.05).clamp(16.0, 28.0);
    final double verticalPadding = Responsive.h(context, 0.02).clamp(12.0, 24.0);
    final double maxContainerWidth = isLandscape ? 860.0 : Responsive.maxContentWidth;

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _showExitConfirmationDialog(context, quiz);
      },
      child: Scaffold(
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
              constraints: BoxConstraints(maxWidth: maxContainerWidth),
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: verticalPadding,
                ),
                child: isLandscape
                    ? _buildLandscapeLayout(
                        context,
                        quiz,
                        currentQuestion,
                        questionNumber,
                        selectedOption,
                      )
                    : _buildPortraitLayout(
                        context,
                        quiz,
                        currentQuestion,
                        questionNumber,
                        selectedOption,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Layout 1 kolom untuk orientasi Portrait
  Widget _buildPortraitLayout(
    BuildContext context,
    QuizProvider quiz,
    Question currentQuestion,
    int questionNumber,
    int? selectedOption,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 1. Header Sapaan Pengguna
        _buildUserHeader(context, quiz.userName),
        SizedBox(height: Responsive.h(context, 0.02).clamp(10.0, 16.0)),

        // 2. Bilah Progres Kuis (QuizProgressBar)
        QuizProgressBar(
          current: questionNumber,
          total: quiz.totalQuestions,
        ),
        SizedBox(height: Responsive.h(context, 0.02).clamp(12.0, 18.0)),

        // 3. Kartu Pertanyaan (QuestionCard)
        QuestionCard(
          questionNumber: questionNumber,
          totalQuestions: quiz.totalQuestions,
          questionText: currentQuestion.questionText,
        ),
        SizedBox(height: Responsive.h(context, 0.02).clamp(12.0, 18.0)),

        // 4. Daftar Pilihan Jawaban (OptionTile)
        _buildOptionList(context, quiz, currentQuestion, selectedOption),
        SizedBox(height: Responsive.h(context, 0.02).clamp(12.0, 20.0)),

        // 5. Tombol Navigasi Bawah
        _buildBottomNavigation(context, quiz),
      ],
    );
  }

  /// Layout 2 kolom untuk orientasi Landscape (soal di kiri, pilihan jawaban di kanan)
  Widget _buildLandscapeLayout(
    BuildContext context,
    QuizProvider quiz,
    Question currentQuestion,
    int questionNumber,
    int? selectedOption,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Kolom Kiri: Header, Progres, dan Pertanyaan
        Expanded(
          flex: 5,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildUserHeader(context, quiz.userName),
              SizedBox(height: Responsive.h(context, 0.02).clamp(8.0, 14.0)),
              QuizProgressBar(
                current: questionNumber,
                total: quiz.totalQuestions,
              ),
              SizedBox(height: Responsive.h(context, 0.02).clamp(10.0, 16.0)),
              QuestionCard(
                questionNumber: questionNumber,
                totalQuestions: quiz.totalQuestions,
                questionText: currentQuestion.questionText,
              ),
            ],
          ),
        ),
        SizedBox(width: Responsive.w(context, 0.03).clamp(16.0, 24.0)),

        // Kolom Kanan: Pilihan Jawaban dan Tombol Navigasi
        Expanded(
          flex: 6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildOptionList(context, quiz, currentQuestion, selectedOption),
              SizedBox(height: Responsive.h(context, 0.02).clamp(10.0, 16.0)),
              _buildBottomNavigation(context, quiz),
            ],
          ),
        ),
      ],
    );
  }

  /// Membangun daftar pilihan jawaban
  Widget _buildOptionList(
    BuildContext context,
    QuizProvider quiz,
    Question currentQuestion,
    int? selectedOption,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Pilih satu jawaban yang paling tepat:',
          style: TextStyle(
            fontSize: Responsive.sp(context, 0.032, min: 12.0, max: 13.0),
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
          ),
        ),
        SizedBox(height: Responsive.h(context, 0.012).clamp(8.0, 12.0)),
        ...List.generate(currentQuestion.options.length, (index) {
          final String label =
              index < _optionLabels.length ? _optionLabels[index] : '${index + 1}';
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
      ],
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
                    color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  /// Membangun barisan tombol navigasi sebelumnya & berikutnya / selesai
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
              height: Responsive.h(context, 0.065).clamp(46.0, 54.0),
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
                _handleFinishQuiz(context, quiz);
              } else {
                quiz.next();
              }
            },
          ),
        ),
      ],
    );
  }

  /// Menangani aksi selesai kuis dengan dialog konfirmasi jika masih ada soal belum terjawab
  void _handleFinishQuiz(BuildContext context, QuizProvider quiz) {
    if (quiz.hasUnansweredQuestions) {
      showDialog(
        context: context,
        builder: (dialogContext) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            title: const Row(
              children: [
                Icon(Icons.warning_amber_rounded, color: AppColors.warning),
                SizedBox(width: 8),
                Text(AppStrings.confirmSubmitTitle),
              ],
            ),
            content: Text(
              'Masih ada ${quiz.unansweredCount} dari ${quiz.totalQuestions} pertanyaan yang belum kamu jawab.\n\nApakah kamu yakin ingin menyelesaikan kuis sekarang?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(dialogContext),
                child: const Text('Periksa Kembali'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                onPressed: () {
                  Navigator.pop(dialogContext);
                  quiz.finish();
                  Navigator.pushReplacementNamed(context, AppRoutes.result);
                },
                child: const Text(AppStrings.submitDialog),
              ),
            ],
          );
        },
      );
    } else {
      quiz.finish();
      Navigator.pushReplacementNamed(context, AppRoutes.result);
    }
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
