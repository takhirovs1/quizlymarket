part of 'test_bloc.dart';

class TestState extends Equatable {
  const TestState({
    this.status = Status.initial,
    this.tests = FakeModel.questions,
    this.currentQuestionIndex = 0,
    this.revealAnswer = false,
  });

  final Status status;
  final List<QuestionModel> tests;
  final int currentQuestionIndex;
  final bool revealAnswer;

  @override
  List<Object?> get props => [status, tests, currentQuestionIndex, revealAnswer];

  TestState copyWith({Status? status, List<QuestionModel>? tests, int? currentQuestionIndex, bool? revealAnswer}) =>
      TestState(
        status: status ?? this.status,
        tests: tests ?? this.tests,
        currentQuestionIndex: currentQuestionIndex ?? this.currentQuestionIndex,
        revealAnswer: revealAnswer ?? this.revealAnswer,
      );
}
