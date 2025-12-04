part of 'tests_bloc.dart';

class TestsState extends Equatable {
  const TestsState({this.status = Status.initial, this.tests = const [], this.error});

  final Status status;
  final List<TestModel> tests;
  final String? error;

  TestsState copyWith({Status? status, List<TestModel>? tests, ValueGetter<String?>? error}) => TestsState(
    status: status ?? this.status,
    tests: tests ?? this.tests,
    error: error != null ? error() : this.error,
  );

  @override
  List<Object?> get props => [status, tests, error];

  T when<T>({
    required T Function() initial,
    required T Function() loading,
    required T Function(List<TestModel> tests) success,
    required T Function() empty,
    required T Function(Object? error) error,
  }) => switch (status) {
    Status.initial => initial(),
    Status.loading => loading(),
    Status.success when tests.isNotEmpty => success(tests),
    Status.success => empty(),
    Status.error => error(error),
    Status.searching => initial(),
    Status.loadingMore => initial(),
  };
}
