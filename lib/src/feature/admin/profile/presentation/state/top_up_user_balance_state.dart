import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/util/logger.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/custom_text_filed.dart';
import '../screen/top_up_user_balance_screen.dart';

abstract class TopUpUserBalanceState extends State<TopUpUserBalanceScreen> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _cardIDController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _setupTelegramBackButton();
  }

  @override
  void dispose() {
    _teardownTelegramBackButton();
    super.dispose();
  }

  void _setupTelegramBackButton() {
    if (!kIsWeb) return;

    try {
      if (!context.telegramWebApp.isSupported) return;

      context.telegramWebApp.backButton
        ..onClick(_handleTelegramBackButtonPressed)
        ..show();
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to show Telegram back button');
    }
  }

  void _teardownTelegramBackButton() {
    if (!kIsWeb) return;

    try {
      if (!context.telegramWebApp.isSupported) return;

      context.telegramWebApp.backButton
        ..offClick(_handleTelegramBackButtonPressed)
        ..hide();
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to hide Telegram back button');
    }
  }

  void _handleTelegramBackButtonPressed() {
    context.telegramWebApp.hapticFeedback.impactOccurred(.light);
    if (!mounted) return;

    context.pop();
  }

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
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}
