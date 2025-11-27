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
  Widget build(BuildContext context) =>  Scaffold(
     appBar: AppBar(
      title: Text('Cart', style: context.textTheme.nunitoW500s24.copyWith(color: context.color.primary)),
      toolbarHeight: 100,
      centerTitle: true,
      backgroundColor: context.color.transparent,
    ),
    body: const SafeArea(
      child: Column(
        crossAxisAlignment: .start,
        children: [
          
          Text('Card'),
        ],
      ),
    ),
  );
}