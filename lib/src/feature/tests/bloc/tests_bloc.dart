import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../../common/enum/bloc_status_enum.dart';
import '../../../common/util/error_handler.dart';
import '../model/test_model.dart';
import '../repository/tests_repository.dart';

part 'tests_event.dart';
part 'tests_state.dart';

class TestsBloc extends Bloc<TestsEvent, TestsState> {
  TestsBloc({required this.testsRepository, TestsState? initialState}) : super(initialState ?? const TestsState()) {
    on<TestsEvent>(
      (event, emit) => switch (event) {
        final GetTestsEvent e => _onGetTestsEvent(e, emit),
      },
    );
  }
  final TestsRepository testsRepository;

  void _onGetTestsEvent(GetTestsEvent event, Emitter<TestsState> emit) => handle(() async {
    emit(state.copyWith(status: Status.loading));
    final tests = await testsRepository.getTests();
    emit(state.copyWith(status: Status.success, tests: tests));
  }, onError: (error, stackTrace) => emit(state.copyWith(status: Status.error, error: () => error.toString())));
}
