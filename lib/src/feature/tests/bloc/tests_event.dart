part of 'tests_bloc.dart';

sealed class TestsEvent {
  const TestsEvent();
}

final class GetTestsEvent extends TestsEvent {
  const GetTestsEvent();
}