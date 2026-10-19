import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/score_card.dart';

/// Halaman Hasil Kuis (ResultScreen).
/// Menampilkan ucapan selamat, ilustrasi hasil, kartu evaluasi nilai [ScoreCard],
/// pesan motivasi berdasarkan persentase skor, serta tombol ulangi dan kembali ke beranda.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  /// Menentukan pesan apresiasi berdasarkan skor nilai akhir
  String _getFeedbackMessage(int score) {
    if (score == 100) return AppStrings.perfectScoreMessage;
    if (score >= 80) return AppStrings.greatScoreMessage;
    if (score >= 60) return AppStrings.goodScoreMessage;
    return AppStrings.keepLearningMessage;
  }

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final double horizontalPadding = Responsive.w(context, 0.05).clamp(16.0, 28.0);
    final double verticalPadding = Responsive.h(context, 0.025).clamp(16.0, 28.0);
    final bool isLandscape = Responsive.isLandscape(context);
    final double imageSize = isLandscape
        ? Responsive.h(context, 0.22).clamp(75.0, 110.0)
        : Responsive.h(context, 0.22).clamp(130.0, 190.0);
    final String feedbackMessage = _getFeedbackMessage(quiz.score);
    final String displayName =
        quiz.userName.trim().isEmpty ? 'Peserta' : quiz.userName.trim();

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        // Tombol back sistem langsung mengarahkan ke halaman awal dengan reset
        quiz.reset(keepUserName: false);
        Navigator.pushNamedAndRemoveUntil(
          context,
          AppRoutes.welcome,
          (route) => false,
        );
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(AppStrings.resultTitle),
          automaticallyImplyLeading: false,
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // 1. Ilustrasi Hasil (Trophy / Awards)
                    Center(
                      child: Image.asset(
                        AppStrings.trophyResultImage,
                        height: imageSize,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.emoji_events_rounded,
                            size: 80,
                            color: AppColors.accentGold,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: Responsive.h(context, 0.02)),

                    // 2. Sapaan Personal Pengguna
                    Text(
                      'Selamat, $displayName! 🎓',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: Responsive.sp(context, 0.055, min: 20.0, max: 24.0),
                          ),
                    ),
                    const SizedBox(height: 6),

                    // Pesan Feedback Dinamis
                    Text(
                      feedbackMessage,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: Responsive.sp(context, 0.036, min: 13.0, max: 15.0),
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(height: Responsive.h(context, 0.03)),

                    // 3. Kartu Skor Evaluasi (ScoreCard)
                    ScoreCard(
                      score: quiz.score,
                      correctCount: quiz.correctCount,
                      incorrectCount: quiz.incorrectCount,
                      totalQuestions: quiz.totalQuestions,
                    ),
                    SizedBox(height: Responsive.h(context, 0.035)),

                    // 4. Tombol Ulangi Kuis (Reset state tapi simpan nama)
                    PrimaryButton(
                      text: AppStrings.retryButton,
                      icon: Icons.refresh_rounded,
                      onPressed: () {
                        quiz.reset(keepUserName: true);
                        Navigator.pushReplacementNamed(context, AppRoutes.quiz);
                      },
                    ),
                    SizedBox(height: Responsive.h(context, 0.015)),

                    // 5. Tombol Kembali ke Halaman Utama (Reset semua)
                    OutlinedButton.icon(
                      onPressed: () {
                        quiz.reset(keepUserName: false);
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          AppRoutes.welcome,
                          (route) => false,
                        );
                      },
                      icon: const Icon(Icons.home_rounded, size: 20),
                      label: const Text(AppStrings.backToHomeButton),
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        side: const BorderSide(color: AppColors.primary, width: 1.2),
                        padding: EdgeInsets.symmetric(
                          vertical: Responsive.h(context, 0.016).clamp(12.0, 16.0),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
