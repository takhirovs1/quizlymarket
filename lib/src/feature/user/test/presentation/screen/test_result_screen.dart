import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../data/model/test_result_model.dart';
import '../widget/result_info_widget.dart';

class TestResultScreen extends StatefulWidget {
  const TestResultScreen({super.key});

  @override
  State<TestResultScreen> createState() => _TestResultScreenState();
}

class _TestResultScreenState extends State<TestResultScreen> {
  TestResultModel? args;

  String format(Duration duration) {
    final totalMinutes = duration.inMinutes;
    final normalizedMinutes = totalMinutes < 0 ? 0 : totalMinutes;
    final normalizedSeconds = duration.inSeconds.remainder(60).abs();
    return context.l10n.totalTime(normalizedMinutes, normalizedSeconds);
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => setState(() => args = ModalRoute.of(context)?.settings.arguments as TestResultModel?),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView(
      scrollDirection: .vertical,
      padding: Dimension.pAll16,
      children: [
        SizedBox(height: context.telegramWebApp.safeAreaInset.top.toDouble()),
        Center(
          child: SizedBox(
            width: context.width * 0.4,
            height: context.width * 0.4,
            child: Assets.images.robotResult.image(fit: .contain),
          ),
        ),
        Dimension.hBox16,
        Text(
          'Akademik ko\'nikmalar',
          maxLines: 2,
          overflow: .ellipsis,
          style: context.textTheme.sfProW500s22.copyWith(color: context.color.black),
        ),
        Text(
          'Iqtisodiyot sirtqi 2-kurs 2-semistr',
          maxLines: 2,
          overflow: .ellipsis,
          style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
        ),
        Text(
          context.l10n.questionRangeHint(args?.takenQuestions ?? 0, args?.totalQuestions ?? 0),
          style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
        ),
        Dimension.hBox24,
        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.correct, width: 24, height: 24),
          leadingTitle: context.l10n.correct,
          trailingTitle: context.l10n.intToCount(args?.correctCount ?? 0),
        ),
        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.incorrect, width: 24, height: 24),
          leadingTitle: context.l10n.wrong,
          trailingTitle: context.l10n.intToCount(args?.incorrectCount ?? 0),
        ),
        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.hourglass, width: 24, height: 24),
          leadingTitle: context.l10n.skipped,
          trailingTitle: context.l10n.intToCount(args?.unselectedCount ?? 0),
        ),
        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.clock, width: 24, height: 24),
          leadingTitle: context.l10n.time,
          trailingTitle: format(args?.totalTime ?? Duration.zero),
        ),
      ],
    ),

    bottomNavigationBar: Padding(
      padding: Dimension.pAll16,
      child: CustomButton(
        onRightPressed: () => context
          ..telegramWebApp.hapticFeedback.impactOccurred(.light)
          ..goReplacementNamed(Routes.home),
        rightText: context.l10n.exit,
      ),
    ),
  );
}
