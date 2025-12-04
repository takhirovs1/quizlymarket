import 'package:flutter/material.dart';

import '../../../../../common/enum/user_role_enum.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../data/model/user_list_model.dart';
import '../state/top_up_user_balance_state.dart';
import '../widget/user_tile_widget.dart';

class TopUpUserBalanceScreen extends StatefulWidget {
  const TopUpUserBalanceScreen({super.key});

  @override
  State<TopUpUserBalanceScreen> createState() => _TopUpUserBalanceScreenState();
}

class _TopUpUserBalanceScreenState extends TopUpUserBalanceState {
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
    body: Column(
      crossAxisAlignment: .start,
      children: [
        Padding(
          padding: Dimension.pAll16,
          child: Text(
            context.l10n.users,
            style: context.textTheme.sfProW300s18.copyWith(color: context.color.black, fontWeight: FontWeight.w700),
          ),
        ),
        Flexible(
          child: ListView.separated(
            itemBuilder: (context, index) => UserTile(
              user: const ClientModel(
                userID: 'John Doe',
                telegramID: 123312312,
                name: 'John Doe',
                createdAt: '2021-01-01',
                balance: 100000,
                role: UserRole.user,
                telegramUsername: 'john_doe',
              ),
              onTap: () {
                context.telegramWebApp.hapticFeedback.impactOccurred(.light);
              },
            ),
            separatorBuilder: (context, index) => Dimension.divider,
            itemCount: 20,
          ),
        ),
      ],
    ),
    bottomNavigationBar: Padding(
      padding: Dimension.pAll16,
      child: CustomButton(onRightPressed: onTopUpButtonPressed, rightText: context.l10n.topUp),
    ),
  );
}
