import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';
import '../../../../common/extension/int_extension.dart';
import '../../../../common/util/dimension.dart';

/// {@template bank_card_widget}
/// A widget that displays a bank card.
/// {@endtemplate}

class BankCardWidget extends StatelessWidget {
  const BankCardWidget({
    required this.fullName,
    required this.balance,
    required this.id,
    super.key,
  });

  final String fullName;
  final int balance;
  final String id;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: context.width,
    child: DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: Dimension.rAll20,
        gradient: LinearGradient(
          colors: [context.color.primaryContainer, context.color.primary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Padding(
        padding: Dimension.pAll16,
        child: Column(
          crossAxisAlignment: .end,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  fullName,
                  style: context.textTheme.nunitoW600s16.copyWith(
                    color: context.color.white,
                  ),
                ),
                Text(
                  'Balance',
                  style: context.textTheme.nunitoW500s14.copyWith(
                    color: context.color.white,
                  ),
                ),
              ],
            ),
            Text(
              balance.toUZSString(),
              style: context.textTheme.nunitoW600s30.copyWith(
                color: context.color.white,
              ),
            ),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'QuizlyMarket Card',
                  style: context.textTheme.nunitoW600s16.copyWith(
                    color: context.color.white,
                  ),
                ),
                Text(
                  id,
                  style: context.textTheme.nunitoW500s14.copyWith(
                    color: context.color.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
