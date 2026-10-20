import '../models/question.dart';

/// Daftar data soal kuis seputar Pemrograman Mobile (Dart & Flutter).
/// Semua soal disimpan dalam SATU List agar efisien dan mudah dikelola.
final List<Question> dummyQuestions = [
  const Question(
    id: 1,
    questionText: 'Widget apa di Flutter yang digunakan untuk komponen antarmuka yang tidak memiliki perubahan state internal selama runtime?',
    options: [
      'StatefulWidget',
      'StatelessWidget',
      'InheritedWidget',
      'RenderObjectWidget',
    ],
    correctIndex: 1,
    explanation: 'StatelessWidget bersifat statis dan tidak memerlukan pembaruan state internal setelah dibangun pertama kali.',
  ),
  const Question(
    id: 2,
    questionText: 'Fitur di Flutter yang memungkinkan pengembang melihat hasil perubahan kode dalam hitungan detik tanpa mereset state aplikasi disebut...',
    options: ['Hot Restart', 'Hot Reload', 'Full Rebuild', 'Cold Boot'],
    correctIndex: 1,
    explanation: 'Hot Reload menginjeksi kode baru ke VM Dart tanpa mereset state yang sedang aktif di aplikasi.',
  ),
  const Question(
    id: 3,
    questionText: 'Dalam bahasa pemrograman Dart, kata kunci apa yang digunakan untuk mendeklarasikan nilai konstan pada saat kompilasi (compile-time constant)?',
    options: ['final', 'var', 'const', 'static'],
    correctIndex: 2,
    explanation: 'Keyword "const" digunakan untuk nilai konstanta waktu kompilasi, sedangkan "final" dievaluasi saat runtime.',
  ),
  const Question(
    id: 4,
    questionText: 'Objek apa di Flutter yang menangani dan merepresentasikan lokasi suatu widget dalam hierarki pohon widget (widget tree)?',
    options: ['WidgetState', 'RenderBox', 'BuildContext', 'ElementTree'],
    correctIndex: 2,
    explanation: 'BuildContext merupakan pegangan (handle) untuk lokasi sebuah widget di dalam widget tree.',
  ),
  const Question(
    id: 5,
    questionText: 'Method lifecycle mana pada State dari StatefulWidget yang hanya dieksekusi satu kali saat widget pertama kali dibuat?',
    options: ['build()', 'didUpdateWidget()', 'dispose()', 'initState()'],
    correctIndex: 3,
    explanation: 'initState() dipanggil tepat satu kali saat objek State pertama kali dimasukkan ke dalam widget tree.',
  ),
  const Question(
    id: 6,
    questionText: 'Widget layout apa yang digunakan untuk menyusun widget-widget anaknya secara vertikal berurutan dari atas ke bawah?',
    options: ['Row', 'Column', 'Stack', 'Wrap'],
    correctIndex: 1,
    explanation: 'Column menampilkan daftar widget anak dalam susunan vertikal, sedangkan Row dalam susunan horizontal.',
  ),
  const Question(
    id: 7,
    questionText: 'Widget apa yang sangat efektif membungkus konten formulir untuk mencegah terjadinya layout overflow saat keyboard virtual muncul di layar?',
    options: ['SingleChildScrollView', 'Container', 'SizedBox', 'Padding'],
    correctIndex: 0,
    explanation: 'SingleChildScrollView memungkinkan satu child widget untuk digulir saat ruang layar terbatas, mencegah error overflow.',
  ),
  const Question(
    id: 8,
    questionText: 'Dalam arsitektur Provider, class apa dari Flutter foundation yang di-extend untuk menyediakan notifikasi perubahan state kepada listener?',
    options: [
      'StreamController',
      'ChangeNotifier',
      'StatefulBuilder',
      'ValueKey',
    ],
    correctIndex: 1,
    explanation: 'ChangeNotifier menyediakan fungsi notifyListeners() yang memberi tahu widget consumer ketika ada perubahan data state.',
  ),
  const Question(
    id: 9,
    questionText: 'Operator apa di bahasa Dart yang digunakan untuk memberikan nilai alternatif (fallback) jika suatu ekspresi bernilai null (null-coalescing)?',
    options: ['?.', '!', '??', '?:'],
    correctIndex: 2,
    explanation: 'Operator "??" (if-null / null-coalescing) mengembalikan nilai sisi kanan hanya apabila sisi kirinya bernilai null.',
  ),
  const Question(
    id: 10,
    questionText: 'Widget apa di Flutter yang digunakan untuk mendeteksi interaksi pengguna (seperti tap, pan, swipe) tanpa memberikan efek visual animasi ripple?',
    options: ['InkWell', 'GestureDetector', 'ElevatedButton', 'IconButton'],
    correctIndex: 1,
    explanation: 'GestureDetector menangkap berbagai macam gestur sentuhan murni tanpa efek visual splash material (seperti yang ada pada InkWell).',
  ),
];
