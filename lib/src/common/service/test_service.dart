// import 'dart:developer';
// import 'dart:io';
// import 'package:excel/excel.dart';
// import '../model/test_model.dart';

// sealed class TestService {
//   static Future<TestModel> xlsxToModel(String path) async {
//     final bytes = await File(path).readAsBytes();
//     final excel = Excel.decodeBytes(bytes);

//     if (excel.tables.isEmpty) throw Exception('Excel file has no sheets');
//     final sheetName = excel.tables.keys.first;
//     final table = excel.tables[sheetName]!;

//     final testId = 'test_${DateTime.now().millisecondsSinceEpoch}';
//     var questions = <QuestionModel>[];
//     var questionIndex = 0;

//     var skipHeader = true;
//     for (final row in table.rows) {
//       if (row.isEmpty || row[0]?.value == null) continue;
//       if (skipHeader) {
//         skipHeader = false;
//         final firstCell = row[0]?.value.toString().toLowerCase() ?? '';
//         if (firstCell.contains('question')) continue;
//       }

//       final questionText = row[0]?.value.toString().trim() ?? '';
//       if (questionText.isEmpty) continue;

//       var answers = List.generate(4, (i) {
//         final answerText = row[i + 1]?.value.toString().trim() ?? '';
//         return AnswerModel(
//           id: '${questionIndex}a$i',
//           questionId: 'q$questionIndex',
//           answer: answerText,
//           isCorrect: i == 0,
//         );
//       });

//       questions.add(QuestionModel(id: 'q$questionIndex', testId: testId, question: questionText, answers: answers));

//       questionIndex++;
//     }

//     if (questions.isEmpty) throw Exception('No questions found');

//     final title = File(path).uri.pathSegments.last.replaceAll('.xlsx', '');
//     log('title: $title');
//     return TestModel(
//       id: testId,
//       subjectId: 0,
//       title: title,
//       price: 0,
//       description: '',
//       createdAt: DateTime.now(),
//       questionCount: questions.length,
//       timeLimitMinutes: 0,
//       isActive: true,
//       questions: questions,
//     );
//   }
// }
