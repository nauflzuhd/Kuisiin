import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';

/// Halaman Kuis (Placeholder untuk persiapan navigasi dan verifikasi state di Hari 5).
/// UI lengkap dengan pertanyaan dan opsi jawaban akan diimplementasikan pada Hari 6.
class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizProvider>();
    final double horizontalPadding = Responsive.w(context, 0.06).clamp(16.0, 32.0);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
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
                  // Sapaan Pengguna dari Provider
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.primary.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(
                          Icons.account_circle_rounded,
                          color: AppColors.primary,
                          size: 22,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Halo, ${quiz.userName.isEmpty ? "Peserta" : quiz.userName}!',
                          style: TextStyle(
                            fontSize: Responsive.sp(context, 0.038, min: 13.0, max: 16.0),
                            fontWeight: FontWeight.w600,
                            color: AppColors.primary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: Responsive.h(context, 0.03)),

                  // Card Informasi Navigasi & Status
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Icon(
                            Icons.check_circle_rounded,
                            size: 48,
                            color: AppColors.success,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'Navigasi Berhasil!',
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'State Provider berhasil menyimpan nama "${quiz.userName}".\n'
                            'Total soal siap dimuat: ${quiz.totalQuestions} butir.',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurface
                                      .withValues(alpha: 0.7),
                                ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '(Tampilan kartu soal & opsi jawaban interaktif akan dirakit pada Hari 6)',
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                  fontStyle: FontStyle.italic,
                                  color: AppColors.primary,
                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: Responsive.h(context, 0.04)),

                  // Tombol Simulasi ke Halaman Hasil
                  PrimaryButton(
                    text: 'Coba Navigasi ke Halaman Hasil',
                    icon: Icons.assessment_rounded,
                    onPressed: () {
                      quiz.finish();
                      Navigator.pushNamed(context, AppRoutes.result);
                    },
                  ),
                  SizedBox(height: Responsive.h(context, 0.015)),

                  // Tombol Kembali ke Welcome
                  OutlinedButton.icon(
                    onPressed: () {
                      quiz.reset(keepUserName: false);
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        AppRoutes.welcome,
                        (route) => false,
                      );
                    },
                    icon: const Icon(Icons.arrow_back_rounded, size: 18),
                    label: const Text('Ganti Nama / Kembali'),
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
