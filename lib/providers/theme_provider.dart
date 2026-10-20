import 'package:flutter/material.dart';

/// Provider untuk mengelola preferensi tema aplikasi (Light Mode & Dark Mode).
/// Memanfaatkan ChangeNotifier agar pembaruan tema langsung diterapkan di seluruh widget tree.
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  /// Mendapatkan mode tema saat ini.
  ThemeMode get themeMode => _themeMode;

  /// Memeriksa apakah saat ini sedang dalam mode gelap.
  bool get isDarkMode => _themeMode == ThemeMode.dark;

  /// Mengganti tema antara Terang dan Gelap.
  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }

  /// Menentukan mode tema secara eksplisit.
  void setThemeMode(ThemeMode mode) {
    if (_themeMode != mode) {
      _themeMode = mode;
      notifyListeners();
    }
  }
}
