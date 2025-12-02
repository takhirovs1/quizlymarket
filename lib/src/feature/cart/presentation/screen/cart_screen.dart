import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';
import '../../../../common/widget/custom_card_widget.dart';
import '../state/card_state.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends CartState {
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
          buttonText: context.l10n.openTest,
          onPressed: onOpenTestScreen,
        ),
        separatorBuilder: (context, index) => Dimension.hBox12,
        itemCount: 2,
      ),
    ),
  );
}
