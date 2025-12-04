class TestModel {
  const TestModel({
    required this.id,
    required this.subjectId,
    required this.title,
    required this.price,
    required this.description,
    required this.createdAt,
    required this.questionCount,
    required this.timeLimitMinutes,
    required this.isActive,
    required this.questions,
  });
  factory TestModel.fromJson(Map<String, Object?> json) => TestModel(
    id: json['id'] as String? ?? '',
    subjectId: json['subject_id'] as int? ?? 0,
    title: json['title'] as String? ?? '',
    price: (json['price'] as num?)?.toDouble() ?? 0,
    description: json['description'] as String? ?? '',
    createdAt: DateTime.parse(json['created_at'] as String? ?? ''),
    questionCount: (json['question_count'] as num?)?.toInt() ?? 0,
    timeLimitMinutes: (json['time_limit_minutes'] as num?)?.toInt() ?? 0,
    isActive: json['is_active'] as bool? ?? false,
    questions:
        (json['questions'] as List?)?.map((e) => QuestionModel.fromJson(e as Map<String, dynamic>)).toList() ?? [],
  );
  final String id;
  final int subjectId;
  final String title;
  final double price;
  final String description;
  final DateTime createdAt;
  final int questionCount;
  final int timeLimitMinutes;
  final bool isActive;
  final List<QuestionModel> questions;
}

class QuestionModel {
  const QuestionModel({required this.id, required this.testId, required this.question, required this.answers});

  factory QuestionModel.fromJson(Map<String, Object?> json) => QuestionModel(
    id: json['id'] as String? ?? '',
    testId: json['test_id'] as String? ?? '',
    question: json['question'] as String? ?? '',
    answers: (json['answers'] as List?)?.map((e) => AnswerModel.fromJson(e as Map<String, Object?>)).toList() ?? [],
  );
  final String id;
  final String testId;
  final String question;
  final List<AnswerModel> answers;
  QuestionModel copyWith({List<AnswerModel>? answers}) =>
      QuestionModel(id: id, testId: testId, question: question, answers: answers ?? this.answers);
}

class AnswerModel {
  const AnswerModel({required this.id, required this.questionId, required this.answer, required this.isCorrect});

  factory AnswerModel.fromJson(Map<String, Object?> json) => AnswerModel(
    id: json['id'] as String? ?? '',
    questionId: json['question_id'] as String? ?? '',
    answer: json['answer'] as String? ?? '',
    isCorrect: json['is_correct'] as bool? ?? false,
  );
  final String id;
  final String questionId;
  final String answer;
  final bool isCorrect;
}
