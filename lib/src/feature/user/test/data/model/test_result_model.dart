class TestResultModel {
  TestResultModel({
    required this.correctCount,
    required this.incorrectCount,
    required this.unselectedCount,
    required this.totalTime,
    required this.testCount,
    required this.totalQuestions,
    required this.takenQuestions,
  });

  int correctCount;
  int incorrectCount;
  int unselectedCount;
  Duration totalTime;
  int testCount;
  int totalQuestions;
  int takenQuestions;

  TestResultModel copyWith({
    int? correctCount,
    int? incorrectCount,
    int? unselectedCount,
    Duration? totalTime,
    int? testCount,
    int? totalQuestions,
    int? takenQuestions,
  }) => TestResultModel(
    correctCount: correctCount ?? this.correctCount,
    incorrectCount: incorrectCount ?? this.incorrectCount,
    unselectedCount: unselectedCount ?? this.unselectedCount,
    totalTime: totalTime ?? this.totalTime,
    testCount: testCount ?? this.testCount,
    totalQuestions: totalQuestions ?? this.totalQuestions,
    takenQuestions: takenQuestions ?? this.takenQuestions,
  );
}
