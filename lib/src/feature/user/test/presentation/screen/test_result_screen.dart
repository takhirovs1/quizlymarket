import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_button.dart';
import '../widget/result_info_widget.dart';

class TestResultScreen extends StatelessWidget {
  const TestResultScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: ListView(
      scrollDirection: Axis.vertical,
      padding: Dimension.pAll16,
      children: [
        SizedBox(height: context.telegramWebApp.safeAreaInset.top.toDouble()),
        Center(
          child: SizedBox(
            width: context.width * 0.4,
            height: context.width * 0.4,
            child: Assets.images.robotResult.image(fit: BoxFit.contain),
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
          context.l10n.questionRangeHint(100),
          style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
        ),

        Dimension.hBox24,

        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.correct, width: 24, height: 24),
          leadingTitle: context.l10n.correct,
          trailingTitle: context.l10n.intToCount(10),
        ),
        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.incorrect, width: 24, height: 24),
          leadingTitle: context.l10n.wrong,
          trailingTitle: context.l10n.intToCount(20),
        ),
        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.hourglass, width: 24, height: 24),
          leadingTitle: context.l10n.skipped,
          trailingTitle: context.l10n.intToCount(30),
        ),
        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.clock, width: 24, height: 24),
          leadingTitle: context.l10n.time,
          trailingTitle: context.l10n.testTotalTime30Min,
        ),
      ],
    ),

    bottomNavigationBar: Padding(
      padding: Dimension.pAll16,
      child: CustomButton(onRightPressed: () => context.goReplacementNamed(Routes.home), rightText: context.l10n.exit),
    ),
  );
}
