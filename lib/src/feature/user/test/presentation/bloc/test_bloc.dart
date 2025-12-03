import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../common/model/test_model.dart';
import '../../data/model/fake_model.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(const TestState()) {
    on<TestEvent>(_onTestEvent);
    on<TestAnswerEvent>(_onTestAnswerEvent);
    on<ClearTestEvent>(_onClearTestEvent);
  }

  void _onTestEvent(TestEvent event, Emitter<TestState> emit) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success));
  }

  void _onTestAnswerEvent(TestAnswerEvent event, Emitter<TestState> emit) {
    emit(state.copyWith(status: Status.loading));
    emit(state.copyWith(status: Status.success, revealAnswer: true));
  }

  void _onClearTestEvent(ClearTestEvent event, Emitter<TestState> emit) {
    emit(state.copyWith(status: Status.loading));
    var questionIndex = state.currentQuestionIndex;
    if (state.tests.length - 1 > questionIndex) questionIndex++;
    emit(state.copyWith(status: Status.success, revealAnswer: false, currentQuestionIndex: questionIndex));
  }
}
