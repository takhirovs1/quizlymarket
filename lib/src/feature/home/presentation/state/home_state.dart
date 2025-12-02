import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/extension/int_extension.dart';
import '../../../../common/router/route_arguments.dart';
import '../../../../common/util/dimension.dart';
import '../../../../common/util/logger.dart';
import '../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../common/widget/custom_button.dart';
import '../../../../common/widget/custom_primary_dialog.dart';
import '../../../profile/presentation/widget/bank_card_widget.dart';
import '../screen/home_screen.dart';

abstract class HomeState extends State<HomeScreen> {
  HomeState();

  late final WebAppUser? telegramUser;

  @override
  void initState() {
    super.initState();
    telegramUser = _resolveTelegramUser();
  }

  WebAppUser? _resolveTelegramUser() {
    if (!kIsWeb) return null;

    try {
      final telegram = context.telegramWebApp;
      if (!telegram.isSupported) return null;

      return telegram.initDataUnsafe?.user;
    } on Object catch (error, stackTrace) {
      warning(error, stackTrace, 'Failed to read Telegram user data');
      return null;
    }
  }

  void _onCanBuyButtonPressed() {
    context
      ..pop()
      ..showCustomDialog(
        dialog: CustomPrimaryDialog(
          description: context.l10n.testPurchasedDescription,
          onPressed: () {
            context.pop();
            Navigator.of(context).pushNamed(Routes.testInit);
          },

          title: context.l10n.testPurchased,
          buttonText: context.l10n.enterTest,
        ),
      );
  }

  Future<void> onBuyButtonPressed() async => await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: context.color.transparent,
    builder: (ctx) => CustomBottomSheet(
      isScrollable: false,
      maxChildSize: .5,
      bottomNavigationBar: CustomButton(
        onRightPressed: _onCanBuyButtonPressed,
        rightText: context.l10n.buy,
        onLeftPressed: context.pop,
        leftText: context.l10n.cancel,
      ),
      children: [
        Dimension.hBox12,
        const BankCardWidget(fullName: 'John Doe', balance: 1000000, id: '1234567890'),
        Dimension.hBox16,

        Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  'Akademik koʻnikmalar',
                  style: context.textTheme.sfProW500s20.copyWith(
                    color: context.color.black,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  'Alfraganus',
                  style: context.textTheme.sfProW500s18.copyWith(color: context.color.gray),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Text(
              'Iqtisodiyot sirtqi 2-kurs 2-semistr',
              style: context.textTheme.sfProW500s18.copyWith(color: context.color.gray),
              maxLines: 2,
              overflow: .ellipsis,
            ),
            Text(
              '100 ta savol',
              style: context.textTheme.sfProW500s18.copyWith(color: context.color.gray),
              maxLines: 2,
              overflow: .ellipsis,
            ),
            Row(
              spacing: 4,
              children: [
                Lottie.asset(Assets.lottie.money, width: 24, height: 24, repeat: false),
                Text(
                  10000.toUZSString(),
                  style: context.textTheme.sfProW500s26.copyWith(
                    color: context.color.primary,
                    fontStyle: .normal,
                    fontWeight: .w700,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  );
}
