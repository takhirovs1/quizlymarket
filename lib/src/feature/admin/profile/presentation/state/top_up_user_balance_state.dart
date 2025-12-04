import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/custom_text_filed.dart';
import '../screen/top_up_user_balance_screen.dart';

abstract class TopUpUserBalanceState extends State<TopUpUserBalanceScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardIDController = TextEditingController();

  void onTopUpButtonPressed() {
    context.telegramWebApp.hapticFeedback.impactOccurred(.light);
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.color.transparent,
      builder: (ctx) => CustomBottomSheet(
        bottomNavigationBar: CustomButton(
          onRightPressed: () {
            context.telegramWebApp.hapticFeedback.notificationOccurred(.success);
            context.pop();
          },
          rightText: context.l10n.add,
          onLeftPressed: () {
            context.telegramWebApp.hapticFeedback.notificationOccurred(.error);
            context.pop();
          },
          leftText: context.l10n.cancel,
        ),
        children: [
          Text('QuizlyMarket Card ID', style: context.textTheme.sfProW500s18.copyWith(color: context.color.black)),
          Dimension.hBox8,
          CustomTextFiled(
            hintText: context.l10n.cardID,
            controller: _cardIDController,
            keyboardType: TextInputType.number,
            cursorColor: context.color.primary,
            onChanged: (value) {
              setState(() {});
            },
          ),
          Dimension.hBox16,
          Text(context.l10n.amount, style: context.textTheme.sfProW500s18.copyWith(color: context.color.black)),
          Dimension.hBox8,
          CustomTextFiled(
            hintText: context.l10n.enterAmount,
            controller: _amountController,
            cursorColor: context.color.primary,
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {});
            },
          ),
        ],
      ),
    );
  }
}
