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

     backgroundColor: context.color.background,
      appBar: PreferredSize(
        preferredSize:  Size.fromHeight(context.height * 0.1),
        child: SafeArea(
          bottom: false,
          child: SizedBox(
            height: context.height * 0.1,
            child: Center(child: Text('Cart', style: context.textTheme.nunitoW600s24.copyWith(color: context.color.primary))),
          ),
        ),
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