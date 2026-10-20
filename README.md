# Kuisiin — Aplikasi Kuis Pemrograman Mobile

Aplikasi kuis pilihan ganda interaktif berbasis Flutter yang dikembangkan bertahap untuk memenuhi tugas take-home UTS Pemrograman Mobile.

---

## Identitas Mahasiswa
- **Nama:** Muhammad Naufal Zuhdi
- **NIM:**  241401052
- **Lab:**  Pemrograman Mobile 1

---

## Informasi Aplikasi
- **Nama Aplikasi:** Kuisiin
- **Topik Kuis:** Pemrograman Mobile (Dart, Flutter, Konsep Mobile, Arsitektur Aplikasi)
- **Deskripsi:** Aplikasi kuis interaktif yang menguji pemahaman mahasiswa tentang pemrograman mobile. Pengguna memasukkan nama, menjawab 10 pertanyaan pilihan ganda, dan mendapatkan evaluasi skor akhir secara instan.

**Fitur:**
- Input nama pengguna
- Kuis pilihan ganda dengan progres soal
- Skor akhir berdasarkan nama pengguna dan jawaban benar
- Progres kuis tidak hilang saat rotasi layar atau pindah halaman
- (Bonus) Dark & Light mode
- (Bonus) Tampilan adaptif tablet & web
- (Bonus) Peninjauan & pembahasan jawaban kuis (Review Answers)

---

## Dokumentasi & Credit Aset

### Palet Warna (Design Tokens)
- **Primary:** `#6C63FF` (Deep Purple / Indigo)
- **Secondary:** `#FF6584` (Coral Pink)
- **Accent:** `#FFB800` (Gold / Amber)
- **Background Light:** `#F8FAFC` | **Background Dark:** `#0F172A`
- **Surface Light:** `#FFFFFF` | **Surface Dark:** `#1E293B`

### Credit Aset
- **Font:** [Poppins](https://fonts.google.com/specimen/Poppins) oleh Indian Type Foundry / Jonny Pinhorn (Lisensi SIL Open Font License via Google Fonts).
- **Ilustrasi:** [unDraw](https://undraw.co/) oleh Katerina Limpitsouni (Lisensi Open-Source):
  - `assets/images/welcome_hero.png` — Ilustrasi flat vektor *Questions* (unDraw)
  - `assets/images/trophy_result.png` — Ilustrasi flat vektor *Awards & Trophy* (unDraw)
- **Ikon & Logo:** [Lucide Icons](https://lucide.dev/) (Lisensi ISC/MIT):
  - `assets/images/quiz_logo.png` — Logo vektor flat aplikasi Kuisiin
  - `assets/icons/quiz_medal.png` — Ikon medali penghargaan emas (Award Badge)

### Mockup / Prototype
- 

### Screenshot Halaman
| Welcome Screen | Quiz Screen | Result Screen |
| :---: | :---: | :---: |
| *-* | *-* | *-* |

### Video Presentasi
- **Link Video:** *(Akan ditambahkan pada Hari 12 via Google Drive)*

---

## Cara Menjalankan Aplikasi
```bash
# 1. Unduh package dan dependensi
flutter pub get

# 2. Jalankan aplikasi di emulator atau perangkat fisik
flutter run
```

---

## Catatan Perkembangan Harian
- **Hari 1 (11 Okt 2026):** Setup repositori Git, inisialisasi Flutter, setup struktur folder modular (`core/`, `data/`, `models/`, `providers/`, `screens/`, `widgets/`), dan penambahan library `provider`.
- **Hari 2 (12 Okt 2026):**
  - Menentukan konsep tema kuis (Pemrograman Mobile).
  - Mengunduh font lokal Poppins (Regular, Medium, SemiBold, Bold) ke `assets/fonts/`.
  - Menyiapkan aset grafis resolusi tinggi di `assets/images/` dan `assets/icons/`.
  - Mendaftarkan aset dan font di `pubspec.yaml`.
  - Membuat konstanta warna `AppColors` (`lib/core/constants/app_colors.dart`) dan konstanta teks/aset `AppStrings` (`lib/core/constants/app_strings.dart`).
- **Hari 3 (13 Okt 2026):**
  - Membuat model data `Question` (`lib/models/question.dart`).
  - Menyiapkan data dummy kuis berisi 10 pertanyaan Pemrograman Mobile & Flutter dalam satu list (`lib/data/questions_data.dart`).
  - Membuat utility pembantu `Responsive` (`lib/core/utils/responsive.dart`) untuk kalkulasi dimensi dinamis.
  - Mengonfigurasi `AppTheme` (`lib/core/theme/app_theme.dart`) untuk light & dark theme dengan font kustom Poppins.
  - Memasang tema global dan integrasi ke `MaterialApp` (`lib/app.dart`).
- **Hari 4 (14 Okt 2026):**
  - Membuat komponen reusable `PrimaryButton` (`lib/widgets/primary_button.dart`) dengan dimensi dinamis dan handling status loading.
  - Membangun halaman `WelcomeScreen` (`lib/screens/welcome_screen.dart`) berbasis `StatefulWidget` dengan layout responsif terpusat.
  - Menerapkan validasi input nama (tidak boleh kosong, trim spasi, batas karakter) dan pesan error informatif.
  - Menggunakan `SingleChildScrollView` dan `keyboardDismissBehavior` untuk memastikan tampilan bebas overflow saat keyboard virtual aktif maupun saat layar dirotasi (landscape).
  - Mengintegrasikan `WelcomeScreen` ke dalam root `MaterialApp` (`lib/app.dart`).
- **Hari 5 (15 Okt 2026):**
  - Mengimplementasikan `QuizProvider` (`lib/providers/quiz_provider.dart`) berbasis `ChangeNotifier` untuk menyimpan state nama pengguna, index soal, jawaban terpilih, dan evaluasi skor.
  - Memasang `MultiProvider` dan `ChangeNotifierProvider` di atas root `MaterialApp` (`lib/main.dart`) agar state tetap persisten saat rotasi layar atau navigasi halaman.
  - Mendefinisikan konstanta rute `AppRoutes` (`lib/core/constants/app_routes.dart`) dan konfigurasi named routes di `lib/app.dart`.
  - Membuat halaman placeholder `QuizScreen` (`lib/screens/quiz_screen.dart`) dan `ResultScreen` (`lib/screens/result_screen.dart`).
  - Menghubungkan input nama di `WelcomeScreen` agar tersimpan langsung ke `QuizProvider` dan melakukan navigasi ke `QuizScreen`.
- **Hari 6 (16 Okt 2026):**
  - Membuat widget modular `OptionTile` (`lib/widgets/option_tile.dart`) dengan badge huruf (A-D), animasi transisi warna, dan indikator status terpilih.
  - Membuat widget modular `QuestionCard` (`lib/widgets/question_card.dart`) untuk menampilkan kategori topik kuis, nomor urut pertanyaan, dan teks soal responsif.
  - Membuat widget modular `QuizProgressBar` (`lib/widgets/quiz_progress_bar.dart`) dengan indikator teks "Soal X dari Y", persentase pengerjaan, dan visual animated `LinearProgressIndicator`.
  - Merakit tata letak utama `QuizScreen` (`lib/screens/quiz_screen.dart`) yang membaca data dinamis dari `QuizProvider`, menyertakan sapaan pengguna di header, serta tombol navigasi pertanyaan.
- **Hari 9 (19 Okt 2026):**
  - Menyempurnakan logika kuis di `QuizProvider` (`lib/providers/quiz_provider.dart`): persistensi jawaban saat navigasi maju/mundur, evaluasi skor otomatis, proteksi `PopScope`, dan dialog konfirmasi jika masih ada soal belum terjawab saat menekan "Selesai".
  - Membuat widget modular `ScoreCard` (`lib/widgets/score_card.dart`) untuk menampilkan nilai besar rasio /100 dan statistik rincian (benar, salah, total soal).
  - Menyelesaikan antarmuka lengkap `ResultScreen` (`lib/screens/result_screen.dart`) dengan sapaan personal, pesan motivasi dinamis sesuai persentase nilai, tombol "Ulangi Kuis", dan "Kembali ke Beranda".
  - Mengaudit seluruh stylesheet untuk memastikan ukuran dinamis berbasis `Responsive` (kriteria #6) dan mengimplementasikan tata letak adaptif 2 kolom saat layar berada pada orientasi landscape.
- **Hari 10 (20 Okt 2026):**
  - Mengimplementasikan fitur bonus tema ganda (Light & Dark Mode) menggunakan `ThemeProvider` (`lib/providers/theme_provider.dart`) dengan integrasi global pada `MaterialApp`.
  - Membuat widget reusable `ThemeToggleButton` (`lib/widgets/theme_toggle_button.dart`) dengan animasi rotasi/skala halus yang disematkan pada seluruh AppBar layar aplikasi.
  - Membangun fitur peninjauan dan pembahasan kuis lengkap (`ReviewAnswersSheet`) di halaman hasil (`lib/widgets/review_answers_sheet.dart`) untuk menampilkan evaluasi benar/salah setiap butir soal beserta kunci jawaban dan penjelasannya.





