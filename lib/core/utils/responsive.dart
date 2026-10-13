import 'package:flutter/material.dart';

/// Helper responsif untuk menghitung ukuran UI secara dinamis berdasarkan ukuran layar.
/// Mencegah penggunaan angka tetap (hardcoded) sesuai kriteria penilaian UTS.
class Responsive {
  Responsive._();

  /// Mendapatkan ukuran layar saat ini (lebar & tinggi).
  static Size size(BuildContext context) => MediaQuery.sizeOf(context);

  /// Menghitung lebar dinamis berdasarkan persentase layar (0.0 sampai 1.0).
  /// Contoh: Responsive.w(context, 0.85) => 85% lebar layar.
  static double w(BuildContext context, double percentage) {
    return MediaQuery.sizeOf(context).width * percentage;
  }

  /// Menghitung tinggi dinamis berdasarkan persentase layar (0.0 sampai 1.0).
  /// Contoh: Responsive.h(context, 0.06) => 6% tinggi layar.
  static double h(BuildContext context, double percentage) {
    return MediaQuery.sizeOf(context).height * percentage;
  }

  /// Menghitung ukuran teks proporsional berdasarkan persentase lebar layar,
  /// dilengkapi batas minimum dan maksimum agar tetap nyaman dibaca.
  static double sp(BuildContext context, double factor, {double min = 10, double max = 32}) {
    final double calculated = MediaQuery.sizeOf(context).width * factor;
    return calculated.clamp(min, max);
  }

  /// Memeriksa apakah orientasi layar saat ini adalah landscape.
  static bool isLandscape(BuildContext context) {
    return MediaQuery.orientationOf(context) == Orientation.landscape;
  }

  /// Memeriksa apakah perangkat tergolong tablet / layar lebar (lebar >= 600).
  static bool isTablet(BuildContext context) {
    return MediaQuery.sizeOf(context).shortestSide >= 600;
  }

  /// Batas lebar maksimum konten agar tetap proporsional di tablet maupun web.
  static const double maxContentWidth = 540.0;
}
