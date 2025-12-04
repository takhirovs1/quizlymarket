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
  late final ScrollController scrollController;
  Map<int, int> selectedAnswers = {};
  Duration remaining = .zero;
  Timer? timer;
  Stopwatch totalTimer = Stopwatch();
  int correctCount = 0;
  int incorrectCount = 0;
  int unselectedCount = 0;

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
    testResult.value = 0;
    int? index;
    var animateIndex = bloc.state.currentQuestionIndex;
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
      timer = null;
      return;
    } else if (animateIndex == 24) {
      for (var i = 0; i < 25; i++) {
        if (isSelected.value[i] == null) {
          index = i;
          animateIndex = i;
          break;
        }
      }
    }
    context.read<TestBloc>().add(ClearTestEvent(index: index));
    if (animateIndex >= 4 && animateIndex <= 19) {
      scrollController.animateTo(
        animateIndex * 52 - 156,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInBack,
      );
    } else if (animateIndex < 4) {
      scrollController.animateTo(0, duration: const Duration(milliseconds: 200), curve: Curves.easeInBack);
    } else {
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInBack,
      );
    }
    if (isSelected.value[bloc.state.currentQuestionIndex + 1] != null) bloc.add(const TestAnswerEvent());
  }

  void startTimer() {
    args = ModalRoute.of(context)?.settings.arguments as CustomTestSettings?;
    setState(() => remaining = args?.totalTestTime.duration ?? const Duration(minutes: 30));
    timer?.cancel();
    timer = null;
    if (remaining.inSeconds <= 0) return;
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      if (remaining.inSeconds <= 1) {
        unselectedCount = 25 - (correctCount + incorrectCount);
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
    scrollController = ScrollController();
    totalTimer.start();
    bloc = context.read<TestBloc>()..add(FilterTestsEvent(args: args));
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
    timer = null;
    scrollController.dispose();
    super.dispose();
  }
}
