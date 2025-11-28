
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
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(context.height * 0.12),
      child: SafeArea(
        bottom: false,
        child: SizedBox(
          height:  context.height * 0.12,
          child: Center(
            child: Text(
              context.l10n.appName,
              style: context.textTheme.nunitoW600s24.copyWith(
                color: context.color.primary,
              ),
            ),
          ),
        ),
      ),
    ),
    body: SafeArea(
      child: ListView.separated(
        itemBuilder: (context, index) => CustomCardWidget(
          subject: 'Akademik koʻnikmalar',
          university: 'Alfraganus',
          direction: 'Iqtisodiyot sirtqi 2-kurs 2-semistr',
          testCount: 100,
          year: '2025-2026',
          price: 10000,
          buttonText:context.l10n.buy,
          onPressed: () {},
        ),
        separatorBuilder: (context, index) => Dimension.hBox12,
        itemCount: 10,
      ),
    ),
  );
}
