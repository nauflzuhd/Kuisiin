import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/constants/app_colors.dart';
import '../core/constants/app_routes.dart';
import '../core/constants/app_strings.dart';
import '../core/utils/responsive.dart';
import '../providers/quiz_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/theme_toggle_button.dart';

/// Halaman awal (Welcome Screen) aplikasi Kuisiin.
/// Menggunakan [StatefulWidget] untuk mengelola lifecycle [TextEditingController],
/// validasi input nama pengguna, serta memastikan tata letak aman dari keyboard overflow.
class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  final FocusNode _nameFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // Membaca nama yang tersimpan sebelumnya jika ada
    final String initialName = context.read<QuizProvider>().userName;
    _nameController = TextEditingController(text: initialName);

    // Listener untuk memperbarui tampilan saat teks berubah (mis. tombol clear)
    _nameController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _nameFocusNode.dispose();
    super.dispose();
  }

  /// Memvalidasi input nama, menyimpannya ke QuizProvider, lalu berpindah ke halaman kuis.
  void _handleSubmit() {
    // Sembunyikan keyboard
    FocusScope.of(context).unfocus();

    if (_formKey.currentState?.validate() ?? false) {
      final String trimmedName = _nameController.text.trim();

      // Simpan nama ke state global Provider
      final quizProvider = context.read<QuizProvider>();
      quizProvider.setUserName(trimmedName);
      quizProvider.reset(keepUserName: true);

      // Navigasi ke QuizScreen menggunakan named route
      Navigator.pushReplacementNamed(context, AppRoutes.quiz);
    }
  }


  /// Validasi nama pengguna: tidak boleh kosong, spasi berlebih, atau kurang dari 2 karakter.
  String? _validateName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return AppStrings.nameEmptyError;
    }
    final String trimmed = value.trim();
    if (trimmed.length < 2) {
      return 'Nama minimal 2 karakter agar dapat dikenali.';
    }
    if (trimmed.length > 50) {
      return 'Nama terlalu panjang (maksimal 50 karakter).';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final double horizontalPadding = Responsive.w(
      context,
      0.06,
    ).clamp(16.0, 32.0);
    final double verticalPadding = Responsive.h(
      context,
      0.025,
    ).clamp(16.0, 28.0);
    final bool isLandscape = Responsive.isLandscape(context);
    final double heroImageHeight = isLandscape
        ? Responsive.h(context, 0.22).clamp(80.0, 120.0)
        : Responsive.h(context, 0.24).clamp(140.0, 210.0);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: const [
          ThemeToggleButton(),
          SizedBox(width: 8),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: Responsive.maxContentWidth,
            ),
            child: SingleChildScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: verticalPadding,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Badge UTS / Header Pill
                    Center(
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: Responsive.w(
                            context,
                            0.035,
                          ).clamp(12.0, 16.0),
                          vertical: Responsive.h(
                            context,
                            0.008,
                          ).clamp(6.0, 8.0),
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.h(context, 0.02)),

                    // Hero Illustration
                    Center(
                      child: Image.asset(
                        AppStrings.welcomeHeroImage,
                        height: heroImageHeight,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(
                            Icons.school_rounded,
                            size: heroImageHeight * 0.7,
                            color: AppColors.primary,
                          );
                        },
                      ),
                    ),
                    SizedBox(height: Responsive.h(context, 0.02)),

                    // Judul Aplikasi & Subtitle
                    Text(
                      AppStrings.welcomeTitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w800,
                            fontSize: Responsive.sp(
                              context,
                              0.055,
                              min: 20.0,
                              max: 26.0,
                            ),
                          ),
                    ),
                    SizedBox(height: Responsive.h(context, 0.01)),
                    Text(
                      AppStrings.welcomeSubtitle,
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface
                            .withValues(alpha: 0.7),
                        fontSize: Responsive.sp(
                          context,
                          0.035,
                          min: 13.0,
                          max: 15.0,
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.h(context, 0.03)),

                    // Card Input Form
                    Card(
                      elevation: isDark ? 0 : 2,
                      shadowColor: AppColors.primary.withValues(alpha: 0.08),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                        side: BorderSide(
                          color: isDark
                              ? AppColors.darkBorder
                              : AppColors.lightBorder,
                          width: 1,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(
                          Responsive.w(context, 0.05).clamp(16.0, 24.0),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Label Input
                            Text(
                              AppStrings.nameInputLabel,
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    fontSize: Responsive.sp(
                                      context,
                                      0.034,
                                      min: 12.0,
                                      max: 14.0,
                                    ),
                                  ),
                            ),
                            SizedBox(height: Responsive.h(context, 0.01)),

                            // TextFormField Nama
                            TextFormField(
                              controller: _nameController,
                              focusNode: _nameFocusNode,
                              textInputAction: TextInputAction.done,
                              keyboardType: TextInputType.name,
                              textCapitalization: TextCapitalization.words,
                              onFieldSubmitted: (_) => _handleSubmit(),
                              validator: _validateName,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: AppStrings.nameInputHint,
                                prefixIcon: const Icon(
                                  Icons.person_outline_rounded,
                                  color: AppColors.primary,
                                ),
                                suffixIcon: _nameController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(
                                          Icons.close_rounded,
                                          size: 20,
                                        ),
                                        tooltip: 'Hapus teks',
                                        onPressed: () {
                                          _nameController.clear();
                                          _nameFocusNode.requestFocus();
                                        },
                                      )
                                    : null,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: BorderSide(
                                    color: isDark
                                        ? AppColors.darkBorder
                                        : AppColors.lightBorder,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.primary,
                                    width: 1.8,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.error,
                                    width: 1.2,
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide(
                                    color: AppColors.error,
                                    width: 1.8,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: Responsive.h(context, 0.025)),

                            // Tombol Mulai Kuis
                            PrimaryButton(
                              text: AppStrings.startQuizButton,
                              icon: Icons.play_arrow_rounded,
                              onPressed: _handleSubmit,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: Responsive.h(context, 0.025)),

                    // Fitur Highlight Chips
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        _buildFeaturePill(
                          context,
                          icon: Icons.quiz_outlined,
                          label: '10 Pertanyaan',
                        ),
                        _buildFeaturePill(
                          context,
                          icon: Icons.timer_outlined,
                          label: 'Santai & Terstruktur',
                        ),
                        _buildFeaturePill(
                          context,
                          icon: Icons.insights_rounded,
                          label: 'Skor Instan',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// Helper untuk membangun pill informasi fitur mini
  Widget _buildFeaturePill(
    BuildContext context, {
    required IconData icon,
    required String label,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.w(context, 0.028).clamp(10.0, 14.0),
        vertical: Responsive.h(context, 0.007).clamp(4.0, 6.0),
      ),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : AppColors.lightSurface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isDark ? AppColors.darkBorder : AppColors.lightBorder,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: AppColors.primary),
          const SizedBox(width: 6),
          Text(
            label,
            style: TextStyle(
              fontSize: Responsive.sp(context, 0.03, min: 11.0, max: 12.0),
              color: Theme.of(context).colorScheme.onSurface
                  .withValues(alpha: 0.75),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
