import 'package:flutter/foundation.dart';

import '../data/questions_data.dart';
import '../models/question.dart';

/// State management untuk kuis menggunakan ChangeNotifier (Provider).
/// Menyimpan nama pengguna, index soal, jawaban terpilih, dan status selesai.
/// State ini diletakkan di atas MaterialApp sehingga tidak hilang saat rotasi layar.
class QuizProvider with ChangeNotifier {
  final List<Question> _questions = dummyQuestions;

  String _userName = '';
  int _currentIndex = 0;
  late List<int?> _selectedAnswers;
  bool _isFinished = false;

  QuizProvider() {
    _initQuiz();
  }

  /// Inisialisasi daftar jawaban dengan nilai null sesuai jumlah soal.
  void _initQuiz() {
    _selectedAnswers = List<int?>.filled(_questions.length, null);
    _currentIndex = 0;
    _isFinished = false;
  }

  // --- Getters ---
  String get userName => _userName;
  int get currentIndex => _currentIndex;
  List<int?> get selectedAnswers => List.unmodifiable(_selectedAnswers);
  bool get isFinished => _isFinished;
  List<Question> get questions => _questions;

  int get totalQuestions => _questions.length;
  Question get currentQuestion => _questions[_currentIndex];

  /// Mendapatkan indeks jawaban yang dipilih pada soal saat ini (null jika belum dijawab).
  int? get currentAnswer => _selectedAnswers[_currentIndex];

  bool get isFirstQuestion => _currentIndex == 0;
  bool get isLastQuestion => _currentIndex == _questions.length - 1;

  /// Jumlah pertanyaan yang sudah dijawab oleh pengguna.
  int get answeredCount =>
      _selectedAnswers.where((answer) => answer != null).length;

  /// Jumlah pertanyaan yang belum dijawab oleh pengguna.
  int get unansweredCount => totalQuestions - answeredCount;

  /// Memeriksa apakah masih terdapat soal yang belum dijawab.
  bool get hasUnansweredQuestions => unansweredCount > 0;

  /// Memeriksa apakah semua soal sudah dijawab.
  bool get allQuestionsAnswered => answeredCount == totalQuestions;

  /// Jumlah jawaban yang benar.
  int get correctCount {
    int count = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] == _questions[i].correctIndex) {
        count++;
      }
    }
    return count;
  }

  /// Jumlah jawaban yang salah (yang sudah dijawab tapi salah).
  int get incorrectCount {
    int count = 0;
    for (int i = 0; i < _questions.length; i++) {
      if (_selectedAnswers[i] != null &&
          _selectedAnswers[i] != _questions[i].correctIndex) {
        count++;
      }
    }
    return count;
  }

  /// Menghitung skor akhir dalam skala 0 - 100.
  int get score {
    if (_questions.isEmpty) return 0;
    return ((correctCount / _questions.length) * 100).round();
  }

  // --- Actions ---

  /// Menyimpan nama pengguna yang diinput dari WelcomeScreen.
  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  /// Menyimpan jawaban yang dipilih pada soal saat ini.
  void selectAnswer(int optionIndex) {
    if (_currentIndex < 0 || _currentIndex >= _selectedAnswers.length) return;
    _selectedAnswers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  /// Berpindah ke soal berikutnya.
  void next() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  /// Berpindah ke soal sebelumnya.
  void previous() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  /// Berpindah langsung ke soal pada indeks tertentu.
  void jumpToQuestion(int index) {
    if (index >= 0 && index < _questions.length) {
      _currentIndex = index;
      notifyListeners();
    }
  }


  /// Menandai kuis telah selesai dan menghitung hasil.
  void finish() {
    _isFinished = true;
    notifyListeners();
  }

  /// Mengulang kuis dari awal.
  /// Parameter [keepUserName] menentukan apakah nama pengguna tetap dipertahankan.
  void reset({bool keepUserName = true}) {
    if (!keepUserName) {
      _userName = '';
    }
    _initQuiz();
    notifyListeners();
  }
}
