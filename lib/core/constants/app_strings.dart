/// Konstanta teks dan path aset aplikasi Kuisiin.
/// Mengumpulkan seluruh string teks agar konsisten dan mudah dikelola.
class AppStrings {
  AppStrings._();

  // App Info
  static const String appName = 'Kuisiin';
  static const String appTagline = 'Asah Wawasan Mobile Programming Kamu!';
  static const String appDescription =
      'Uji pemahaman kamu seputar pemrograman mobile, Dart, dan Flutter dengan kuis interaktif.';

  // Welcome Screen
  static const String welcomeTitle = 'Selamat Datang di Kuisiin';
  static const String welcomeSubtitle =
      'Masukkan namamu untuk memulai perjalanan kuis hari ini.';
  static const String nameInputLabel = 'Nama Lengkap / Panggilan';
  static const String nameInputHint = 'Contoh: Budi Santoso';
  static const String nameEmptyError = 'Silakan masukkan nama terlebih dahulu!';
  static const String startQuizButton = 'Mulai Kuis';

  // Quiz Screen
  static const String questionHeaderPrefix = 'Soal';
  static const String previousButton = 'Sebelumnya';
  static const String nextButton = 'Selanjutnya';
  static const String finishButton = 'Selesai';
  static const String confirmSubmitTitle = 'Konfirmasi Selesai';
  static const String confirmSubmitMessage =
      'Masih ada pertanyaan yang belum dijawab. Apakah kamu yakin ingin menyelesaikan kuis sekarang?';
  static const String cancelDialog = 'Batal';
  static const String submitDialog = 'Ya, Selesaikan';

  // Result Screen
  static const String resultTitle = 'Hasil Kuis Kamu';
  static const String perfectScoreMessage = 'Luar Biasa! Skor Sempurna! 🎉';
  static const String greatScoreMessage = 'Hebat Sekali! Pertahankan prestasimu! 👏';
  static const String goodScoreMessage = 'Bagus! Terus belajar dan tingkatkan lagi! 💪';
  static const String keepLearningMessage = 'Jangan menyerah! Ayo coba pelajari lagi! 📚';
  static const String totalScoreLabel = 'Skor Akhir';
  static const String correctAnswersLabel = 'Jawaban Benar';
  static const String incorrectAnswersLabel = 'Jawaban Salah';
  static const String retryButton = 'Ulangi Kuis';
  static const String backToHomeButton = 'Kembali ke Beranda';

  // Asset Paths
  static const String logoImage = 'assets/images/quiz_logo.png';
  static const String welcomeHeroImage = 'assets/images/welcome_hero.png';
  static const String trophyResultImage = 'assets/images/trophy_result.png';
  static const String quizMedalIcon = 'assets/icons/quiz_medal.png';

  // Font Families
  static const String fontFamilyPoppins = 'Poppins';
}
