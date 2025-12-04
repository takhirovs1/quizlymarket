part of 'test_bloc.dart';

sealed class TestEvent {
  const TestEvent();
}

final class TestAnswerEvent extends TestEvent {
  const TestAnswerEvent();
}

final class ClearTestEvent extends TestEvent {
  const ClearTestEvent({this.index});
  final int? index;
}

final class FilterTestsEvent extends TestEvent {
  const FilterTestsEvent({this.args});
  final CustomTestSettings? args;
}

final class UniversityTestEvent extends TestEvent {
  const UniversityTestEvent({this.args});
  final CustomTestSettings? args;
}

final class ChangeQuestionEvent extends TestEvent {
  const ChangeQuestionEvent({required this.index, required this.revealAnswer});
  final int index;
  final bool revealAnswer;
}
