import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../providers/theme_provider.dart';

/// Tombol reusable untuk beralih antara Mode Terang (Light Mode) dan Mode Gelap (Dark Mode).
class ThemeToggleButton extends StatelessWidget {
  const ThemeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.watch<ThemeProvider>();
    final bool isDark = themeProvider.isDarkMode;

    return IconButton(
      tooltip: isDark ? 'Beralih ke Mode Terang' : 'Beralih ke Mode Gelap',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        transitionBuilder: (child, animation) {
          return RotationTransition(
            turns: animation,
            child: ScaleTransition(scale: animation, child: child),
          );
        },
        child: Icon(
          isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
          key: ValueKey<bool>(isDark),
          color: isDark ? AppColors.accentGold : AppColors.primary,
        ),
      ),
      onPressed: () {
        themeProvider.toggleTheme();
      },
    );
  }
}
