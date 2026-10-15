import 'package:flutter/material.dart';

import 'core/constants/app_routes.dart';
import 'core/constants/app_strings.dart';
import 'core/theme/app_theme.dart';
import 'screens/quiz_screen.dart';
import 'screens/result_screen.dart';
import 'screens/welcome_screen.dart';

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
      initialRoute: AppRoutes.welcome,
      routes: {
        AppRoutes.welcome: (context) => const WelcomeScreen(),
        AppRoutes.quiz: (context) => const QuizScreen(),
        AppRoutes.result: (context) => const ResultScreen(),
      },
    );
  }
}


