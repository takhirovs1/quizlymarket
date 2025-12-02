import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/router/route_arguments.dart';
import '../../../../common/util/dimension.dart';
import '../../../../common/widget/custom_button.dart';
import '../widget/result_info_widget.dart';

class TestResultScreen extends StatelessWidget {
  const TestResultScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      backgroundColor: context.color.primary,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      toolbarHeight: context.telegramWebApp.safeAreaInset.top + 56,
      surfaceTintColor: context.color.transparent,
    ),
    body: ListView(
      scrollDirection: Axis.vertical,
      padding: Dimension.pAll16,
      children: [
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
          maxLines: 1,
          overflow: .ellipsis,
          style: context.textTheme.sfProW500s22.copyWith(color: context.color.black),
        ),

        Text(
          'Iqtisodiyot sirtqi 2-kurs 2-semistr',
          style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
        ),
        Text(
          'Iqtisodiyot sirtqi 2-kurs 2-semistr',
          style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
        ),

        Dimension.hBox24,
        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.book, width: 24, height: 24, repeat: false),
          leadingTitle: context.l10n.correct,
          trailingTitle: context.l10n.testTotalTime30Min,
          trailingIcon: Lottie.asset(Assets.lottie.book, width: 24, height: 24, repeat: false),
        ),

        ResultInfoWidget(
          leadingIcon: Lottie.asset(Assets.lottie.book, width: 24, height: 24, repeat: false),
          leadingTitle: context.l10n.wrong,
          trailingTitle: context.l10n.testTotalTime30Min,
        ),
      ],
    ),

    bottomNavigationBar: Padding(
      padding: Dimension.pAll16,
      child: CustomButton(onRightPressed: () => context.goNamed(Routes.home), rightText: context.l10n.logoutConfirm),
    ),
  );
}
