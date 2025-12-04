import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_card_widget.dart';
import '../../../../../common/widget/custom_text_filed.dart';
import '../state/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends HomeState {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.background,
    body: SafeArea(
      child: ListView(
        padding: Dimension.pAll16,

        children: [
          CustomTextFiled(
            hintText: context.l10n.search,

            action: IconButton(
              hoverColor: context.color.transparent,
              onPressed: onFilterButtonPressed,
              icon: Lottie.asset(Assets.lottie.money, width: 24, height: 24, repeat: false),

              // icon: Lottie.asset(Assets.lottie.filter, width: 30, height: 30, fit: BoxFit.scaleDown, repeat: false),
            ),
          ),

          Dimension.hBox16,
          ListView.separated(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (context, index) => CustomCardWidget(
              subject: 'Akademik ko\'nikmalar',
              university: 'Alfraganus',
              direction: 'Iqtisodiyot sirtqi 2-kurs 2-semistr',
              testCount: 100,
              studyYears: '2025-2026',
              price: 10000,
              buttonText: context.l10n.buy,
              onPressed: onBuyButtonPressed,
            ),
            separatorBuilder: (context, index) => Dimension.hBox12,
            itemCount: 10,
          ),
        ],
      ),
    ),
  );
}
