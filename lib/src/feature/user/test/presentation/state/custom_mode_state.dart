import 'dart:async';

import 'package:flutter/material.dart';

import '../../data/model/test_init_enum.dart';
import '../screen/custom_mode_screen.dart';

abstract class CustomModeState extends State<CustomModeScreen> {
  late final ValueNotifier<int> testResult;
  Duration remaining = Duration.zero;
  Timer? timer;

  void _startTimer() {
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
    testResult = ValueNotifier(0);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as CustomTestSettings?;
      setState(() => remaining = args?.questionTime.duration ?? const Duration(minutes: 30));
      _startTimer();
    });
  }

  @override
  void dispose() {
    testResult.dispose();
    timer?.cancel();
    super.dispose();
  }
}
