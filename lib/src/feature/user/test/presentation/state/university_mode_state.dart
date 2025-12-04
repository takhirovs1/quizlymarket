import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../data/model/test_init_model.dart';
import '../../data/model/test_result_model.dart';
import '../bloc/test_bloc.dart';
import '../screen/university_mode_screen.dart';

abstract class UniversityModeState extends State<UniversityModeScreen> {
  CustomTestSettings? args;
  late final TestBloc bloc;
  late final ValueNotifier<int> testResult;
  late final ValueNotifier<Map<int, bool>> isSelected;
  Map<int, int> selectedAnswers = {};
  Duration remaining = Duration.zero;
  Timer? timer;
  Stopwatch totalTimer = Stopwatch();
  int correctCount = 0;
  int incorrectCount = 0;
  int unselectedCount = 0;
  bool isInitialized = false;

  Color getColorQuestion(int i, TestState state, {bool? isBg, bool? isText}) {
    final isCorrect = isSelected.value[i];
    return i == state.currentQuestionIndex
        ? context.color.primary.withValues(alpha: (isBg ?? false) ? 0.1 : 1)
        : isCorrect == true
        ? context.color.success.withValues(alpha: (isBg ?? false) ? 0.1 : 1)
        : isCorrect == false
        ? context.color.error.withValues(alpha: (isBg ?? false) ? 0.1 : 1)
        : (isText ?? false)
        ? context.color.black
        : context.color.outline.withValues(alpha: (isBg ?? false) ? 0.1 : 1);
  }

  Color getColor(int i, TestState state, {bool? isBg, bool? isText}) {
    final isCorrect = state.tests[state.currentQuestionIndex].answers[i - 1].isCorrect;
    return (testResult.value == i || isCorrect) && state.revealAnswer
        ? isCorrect
              ? context.color.success.withValues(alpha: (isBg ?? false) ? 0.1 : 1)
              : context.color.error.withValues(alpha: (isBg ?? false) ? 0.1 : 1)
        : (isText ?? false)
        ? context.color.black
        : context.color.outline.withValues(alpha: (isBg ?? false) ? 0.1 : 1);
  }

  void onTimerEnd() {
    if (isSelected.value[bloc.state.currentQuestionIndex] == null &&
        unselectedCount + correctCount + incorrectCount < 25)
      unselectedCount++;
    testResult.value = 0;
    if (25 <= (correctCount + incorrectCount + unselectedCount)) {
      context.goNamed(
        Routes.testResult,
        arguments: TestResultModel(
          correctCount: correctCount,
          incorrectCount: incorrectCount,
          unselectedCount: unselectedCount,
          totalTime: Duration(milliseconds: (totalTimer..stop()).elapsedMilliseconds),
          testCount: bloc.state.tests.length,
          totalQuestions: 25,
          takenQuestions: bloc.state.tests.length,
        ),
      );
      timer?.cancel();
      return;
    }
    context.read<TestBloc>().add(const ClearTestEvent());
  }

  void startTimer() {
    args = ModalRoute.of(context)?.settings.arguments as CustomTestSettings?;
    if (!isInitialized) {
      isInitialized = true;
      context.read<TestBloc>().add(FilterTestsEvent(args: args));
    }
    setState(() => remaining = args?.totalTestTime.duration ?? const Duration(minutes: 30));
    timer?.cancel();
    timer = null;
    if (remaining.inSeconds <= 0) return;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (remaining.inSeconds <= 1) {
        unselectedCount =
            (args?.questionRange.end.toInt() ?? 0) -
            (args?.questionRange.start.toInt() ?? 0) -
            (correctCount + incorrectCount);
        onTimerEnd();
      }
      setState(() => remaining -= const Duration(seconds: 1));
    });
  }

  String format(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '${hours.toString().padLeft(2, '0')}:$minutes:$seconds' : '$minutes:$seconds';
  }

  @override
  void initState() {
    super.initState();
    totalTimer.start();
    bloc = TestBloc();
    testResult = ValueNotifier(0);
    isSelected = ValueNotifier({});
    WidgetsBinding.instance.addPostFrameCallback((_) => startTimer());
  }

  @override
  void dispose() {
    totalTimer.stop();
    bloc.close();
    testResult.dispose();
    isSelected.dispose();
    timer?.cancel();
    super.dispose();
  }
}
