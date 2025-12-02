import 'dart:async';

import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';
import '../../../../common/router/route_arguments.dart';
import '../../../../common/util/dimension.dart';
import '../../../../common/widget/custom_button.dart';
import '../../data/model/test_init_enum.dart';

class CustomModeScreen extends StatefulWidget {
  const CustomModeScreen({super.key});

  @override
  State<CustomModeScreen> createState() => _CustomModeScreenState();
}

class _CustomModeScreenState extends State<CustomModeScreen> {
  Duration _remaining = Duration.zero;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final args = ModalRoute.of(context)?.settings.arguments as CustomTestSettings?;
      setState(() {
        _remaining = args?.questionTime.duration ?? const Duration(minutes: 30);
      });
      _startTimer();
    });
  }

  void _startTimer() {
    _timer?.cancel();
    if (_remaining.inSeconds <= 0) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_remaining.inSeconds <= 1) {
        setState(() => _remaining = Duration.zero);
        timer.cancel();
        return;
      }
      setState(() => _remaining -= const Duration(seconds: 1));
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _format(Duration duration) {
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return hours > 0 ? '${hours.toString().padLeft(2, '0')}:$minutes:$seconds' : '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.white,
    appBar: AppBar(
      backgroundColor: context.color.primary,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      toolbarHeight: context.height * .10,
      surfaceTintColor: Colors.transparent,
      title: Column(
        children: [
          SizedBox(height: context.height * .02),
          Text(_format(_remaining), style: context.textTheme.nunitoW600s24.copyWith(color: context.color.white)),
        ],
      ),
    ),
    bottomNavigationBar: Padding(
      padding: Dimension.pAll16,
      child: CustomButton(onRightPressed: () => context.goNamed(Routes.testResult), rightText: context.l10n.startTest),
    ),
    body: ListView(
      padding: Dimension.pAll16,
      children: [Text('Custom Mode', style: context.textTheme.sfProW500s18)],
    ),
  );
}
