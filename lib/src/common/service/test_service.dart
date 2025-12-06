import 'dart:developer';
import 'dart:io';
import 'package:excel/excel.dart';
import '../model/test_model.dart';

sealed class TestService {
  const TestService._();

  static Future<TestModel> xlsxToModel(String path) async {
    final bytes = await _loadBytes(path);
    final excel = Excel.decodeBytes(bytes);

    if (excel.tables.isEmpty) throw Exception('Excel file has no sheets');
    final table = excel.tables.values.first;

    final testId = 'test_${DateTime.now().millisecondsSinceEpoch}';
    final questions = _parseRows(table.rows, testId);

    if (questions.isEmpty) throw Exception('No questions found');

    final title = path.split('/').last.replaceAll('.xlsx', '');
    log('title: $title');

    return TestModel(
      id: testId,
      subjectId: 0,
      title: title,
      price: 0,
      description: '',
      createdAt: DateTime.now(),
      questionCount: questions.length,
      timeLimitMinutes: 0,
      isActive: true,
      questions: questions,
    );
  }

  static Future<List<int>> _loadBytes(String path) async {
    final bytes = await File(path).readAsBytes();
    return bytes;
  }

  static List<QuestionModel> _parseRows(List<List<Data?>> rows, String testId) {
    var result = <QuestionModel>[];
    var questionIndex = 0;
    var skipHeader = true;

    for (final row in rows) {
      final unsuitable = row.isEmpty || row[0]?.value == null;
      if (unsuitable) continue;

      if (skipHeader) {
        skipHeader = false;
        final firstCell = row[0]?.value.toString().toLowerCase() ?? '';
        if (firstCell.contains('question')) continue;
      }

      final questionText = row[0]?.value.toString().trim() ?? '';
      if (questionText.isEmpty) continue;

      var answers = List.generate(4, (i) {
        final text = row[i + 1]?.value.toString().trim() ?? '';
        return AnswerModel(id: '${questionIndex}a$i', questionId: 'q$questionIndex', answer: text, isCorrect: i == 0);
      });

      result.add(QuestionModel(id: 'q$questionIndex', testId: testId, question: questionText, answers: answers));

      questionIndex++;
    }

    return result;
  }
}
