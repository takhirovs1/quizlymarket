import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';
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
      child: Column(crossAxisAlignment: .start, children: [Text(context.l10n.cart)]),
    ),
  );
}
