import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';

class TopUpUserBalanceScreen extends StatefulWidget {
  const TopUpUserBalanceScreen({super.key});

  @override
  State<TopUpUserBalanceScreen> createState() => _TopUpUserBalanceScreenState();
}

class _TopUpUserBalanceScreenState extends State<TopUpUserBalanceScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.background,
    appBar: AppBar(
      backgroundColor: context.color.primary,
      automaticallyImplyLeading: false,
      scrolledUnderElevation: 0,
      elevation: 0,
      toolbarHeight: context.telegramWebApp.safeAreaInset.top + 56,
      surfaceTintColor: context.color.transparent,
      title: Column(
        children: [
          SizedBox(height: context.telegramWebApp.safeAreaInset.top.toDouble()),
          Center(
            child: Text(
              context.l10n.topUpUserBalance,
              style: context.textTheme.nunitoW600s24.copyWith(color: context.color.white),
            ),
          ),
        ],
      ),
    ),
  );
}
