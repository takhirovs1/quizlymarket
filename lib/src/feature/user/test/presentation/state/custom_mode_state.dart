import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../data/model/test_init_enum.dart';
import '../bloc/test_bloc.dart';
import '../screen/custom_mode_screen.dart';

abstract class CustomModeState extends State<CustomModeScreen> {
  late final TestBloc bloc;
  late final ValueNotifier<int> testResult;
  bool isSelected = false;
  Duration remaining = Duration.zero;
  Timer? timer;

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

  void startTimer() {
    timer?.cancel();
    if (remaining.inSeconds <= 0) return;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (remaining.inSeconds <= 1) {
        setState(() => remaining = Duration.zero);
        timer.cancel();
        return;
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
    bloc = TestBloc();
    testResult = ValueNotifier(0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as CustomTestSettings?;
      setState(() => remaining = args?.questionTime.duration ?? const Duration(minutes: 30));
      startTimer();
    });
  }

  @override
  void dispose() {
    bloc.close();
    testResult.dispose();
    timer?.cancel();
    super.dispose();
  }
}
