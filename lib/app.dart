import 'package:flutter/material.dart';

import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/responsive.dart';
import 'data/questions_data.dart';

class KuisiinApp extends StatelessWidget {
  const KuisiinApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.w(context, 0.06);

    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: Responsive.maxContentWidth),
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  AppStrings.logoImage,
                  width: Responsive.w(context, 0.28).clamp(80.0, 130.0),
                  height: Responsive.w(context, 0.28).clamp(80.0, 130.0),
                ),
                SizedBox(height: Responsive.h(context, 0.02)),
                Text(
                  AppStrings.appName,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                SizedBox(height: Responsive.h(context, 0.01)),
                Text(
                  AppStrings.appTagline,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                ),
                SizedBox(height: Responsive.h(context, 0.03)),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        const Icon(
                          Icons.quiz_outlined,
                          size: 40,
                          color: Color(0xFF6C63FF),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Data Soal Siap Digunakan',
                          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Tersedia ${dummyQuestions.length} pertanyaan seputar Pemrograman Mobile & Flutter.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                                color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.65),
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: Responsive.h(context, 0.03)),
                Text(
                  'Hari 3: Tema, Model & Data Soal Selesai',
                  style: TextStyle(
                    fontSize: Responsive.sp(context, 0.035, min: 12, max: 14),
                    fontWeight: FontWeight.w500,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
