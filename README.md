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
