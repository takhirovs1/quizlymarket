import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';
import '../../../../common/widget/custom_card_widget.dart';
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
      child: ListView.separated(
        padding: Dimension.pTop16,
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
    ),
  );
}
