part of 'test_bloc.dart';

sealed class TestEvent {
  const TestEvent();
}

final class TestAnswerEvent extends TestEvent {
  const TestAnswerEvent();
}

final class ClearTestEvent extends TestEvent {
  const ClearTestEvent();
}

final class FilterTestsEvent extends TestEvent {
  const FilterTestsEvent({this.args});
  final CustomTestSettings? args;
}
