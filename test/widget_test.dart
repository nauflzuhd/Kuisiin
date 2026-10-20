import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:kuisiin/app.dart';
import 'package:kuisiin/core/constants/app_strings.dart';
import 'package:kuisiin/providers/quiz_provider.dart';
import 'package:kuisiin/providers/theme_provider.dart';

void main() {
  Widget createTestApp() {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => QuizProvider()),
      ],
      child: const KuisiinApp(),
    );
  }

  group('Kuisiin App Widget & Flow Tests', () {
    testWidgets('WelcomeScreen renders title, input name, and start button', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Memastikan elemen utama WelcomeScreen tampil
      expect(find.text(AppStrings.welcomeTitle), findsOneWidget);
      expect(find.text(AppStrings.nameInputLabel), findsOneWidget);
      expect(find.text(AppStrings.startQuizButton), findsOneWidget);
    });

    testWidgets('Validates empty name when start button is clicked', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestApp());
      await tester.pumpAndSettle();

      // Klik tombol mulai kuis tanpa mengisi nama
      final startButton = find.text(AppStrings.startQuizButton);
      await tester.tap(startButton);
      await tester.pumpAndSettle();

      // Memastikan pesan error validasi muncul
      expect(find.text(AppStrings.nameEmptyError), findsOneWidget);
    });
  });

  group('QuizProvider Unit Tests', () {
    test('QuizProvider calculates score and answers correctly', () {
      final quiz = QuizProvider();

      // Awal: belum ada jawaban
      expect(quiz.answeredCount, 0);
      expect(quiz.hasUnansweredQuestions, isTrue);
      expect(quiz.isFinished, isFalse);
      expect(quiz.score, 0);

      // Simpan nama
      quiz.setUserName('Budi Santoso');
      expect(quiz.userName, 'Budi Santoso');

      // Jawab soal pertama dengan kunci jawaban yang benar
      final int correctFirstAnswer = quiz.currentQuestion.correctIndex;
      quiz.selectAnswer(correctFirstAnswer);

      expect(quiz.answeredCount, 1);
      expect(quiz.correctCount, 1);
      expect(quiz.score, greaterThan(0));

      // Reset kuis
      quiz.reset(keepUserName: true);
      expect(quiz.answeredCount, 0);
      expect(quiz.userName, 'Budi Santoso');
      expect(quiz.score, 0);
    });

    test('ThemeProvider toggles between light and dark mode', () {
      final theme = ThemeProvider();

      expect(theme.themeMode, ThemeMode.light);
      expect(theme.isDarkMode, isFalse);

      theme.toggleTheme();
      expect(theme.themeMode, ThemeMode.dark);
      expect(theme.isDarkMode, isTrue);

      theme.toggleTheme();
      expect(theme.themeMode, ThemeMode.light);
      expect(theme.isDarkMode, isFalse);
    });
  });
}
