import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';

/// Halaman Hasil Kuis (Placeholder untuk verifikasi navigasi & state provider di Hari 5).
/// UI detail hasil kuis lengkap akan disempurnakan pada Hari 7 & 8.
class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final double horizontalPadding = Responsive.w(context, 0.06).clamp(16.0, 32.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.resultTitle),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Ilustrasi Hasil / Icon
                  Image.asset(
                    AppStrings.trophyResultImage,
                    height: Responsive.h(context, 0.22).clamp(130.0, 180.0),
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.emoji_events_rounded,
                        size: 80,
                        color: AppColors.accentGold,
                      );
                    },
                  ),
                  SizedBox(height: Responsive.h(context, 0.02)),

                  // Judul & Nama Pengguna
                  Text(
                    'Kuis Selesai!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                        ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Peserta: ${quiz.userName.isEmpty ? "Peserta" : quiz.userName}',
                    style: TextStyle(
                      fontSize: Responsive.sp(context, 0.04, min: 14.0, max: 16.0),
                      color: AppColors.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: Responsive.h(context, 0.03)),

                  // Card Skor Awal
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                      child: Column(
                        children: [
                          Text(
                            AppStrings.totalScoreLabel,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '${quiz.score}',
                            style: TextStyle(
                              fontSize: Responsive.sp(context, 0.12, min: 40.0, max: 56.0),
                              fontWeight: FontWeight.w900,
                              color: AppColors.primary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Benar ${quiz.correctCount} dari ${quiz.totalQuestions} soal',
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(context, 0.035)),

                  // Tombol Ulangi Kuis
                  PrimaryButton(
                    text: AppStrings.retryButton,
                    icon: Icons.refresh_rounded,
                    onPressed: () {
                      quiz.reset(keepUserName: true);
                      Navigator.pushReplacementNamed(context, AppRoutes.quiz);
                    },
                  ),
                  SizedBox(height: Responsive.h(context, 0.015)),

                  // Tombol Kembali ke Halaman Awal
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
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
