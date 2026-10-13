/// Model data untuk satu butir pertanyaan kuis pilihan ganda.
class Question {
  final int id;
  final String questionText;
  final List<String> options;
  final int correctIndex;
  final String? explanation;

  const Question({
    required this.id,
    required this.questionText,
    required this.options,
    required this.correctIndex,
    this.explanation,
  });
}
