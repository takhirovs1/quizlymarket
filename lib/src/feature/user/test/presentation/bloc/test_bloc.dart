import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/enum/bloc_status_enum.dart';
import '../../../../../common/model/test_model.dart';
import '../../data/model/fake_model.dart';
import '../../data/model/test_init_model.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(const TestState()) {
    on<TestAnswerEvent>(_onTestAnswerEvent);
    on<ClearTestEvent>(_onClearTestEvent);
    on<FilterTestsEvent>(_onFilterTestsEvent);
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

  void _onFilterTestsEvent(FilterTestsEvent event, Emitter<TestState> emit) {
    emit(state.copyWith(status: Status.loading));
    var test = List<QuestionModel>.from(
      state.tests.sublist(event.args?.questionRange.start.toInt() ?? 0, event.args?.questionRange.end.toInt() ?? 0),
    );
    if (event.args?.shuffleOption == .all) {
      test.shuffle();
      test = test.map((e) {
        var answer = List<AnswerModel>.from(e.answers)..shuffle();
        return e.copyWith(answers: answer);
      }).toList();
      emit(state.copyWith(status: Status.success, tests: test));
    } else if (event.args?.shuffleOption == .questionsOnly) {
      emit(state.copyWith(status: Status.success, tests: test..shuffle()));
    } else if (event.args?.shuffleOption == .answersOnly) {
      final shuffledTests = test
          .map((question) => question.copyWith(answers: List<AnswerModel>.from(question.answers)..shuffle()))
          .toList();
      emit(state.copyWith(status: Status.success, tests: shuffledTests));
    }
  }
}
