import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/extension/int_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/util/logger.dart';
import '../../../../../common/widget/bank_card_widget.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/custom_primary_dialog.dart';
import '../../../../auth/bloc/auth_bloc.dart';
import '../../../../tests/model/test_model.dart';
import '../screen/home_screen.dart';
import '../widget/filter_bottom_sheet.dart';

abstract class HomeState extends State<HomeScreen> {
  HomeState();

  late final WebAppUser? telegramUser;
  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    telegramUser = _resolveTelegramUser();
    searchController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    searchController.dispose();
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
            context.telegramWebApp.hapticFeedback.selectionChanged();
            Navigator.of(context).pushNamed(Routes.testInit);
          },
          title: context.l10n.testPurchased,
          buttonText: context.l10n.enterTest,
        ),
      );
  }

  Future<void> onBuyButtonPressed(TestModel test) async => await showModalBottomSheet<void>(
    context: context,
    useRootNavigator: true,
    isScrollControlled: true,
    backgroundColor: context.color.transparent,
    builder: (ctx) => CustomBottomSheet(
      isScrollable: false,
      maxChildSize: .5,
      bottomNavigationBar: CustomButton(
        onRightPressed: () {
          context.telegramWebApp.hapticFeedback.notificationOccurred(.success);
          _onCanBuyButtonPressed();
        },
        rightText: context.l10n.buy,
        onLeftPressed: () {
          context.telegramWebApp.hapticFeedback.notificationOccurred(.error);
          context.pop();
        },
        leftText: context.l10n.cancel,
      ),
      children: [
        Dimension.hBox12,
        BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) => BankCardWidget(
            fullName: state.user?.name ?? '',
            balance: state.user?.balance ?? 0,
            id: state.user?.telegramID.toString() ?? '',
            cardName: 'QuizlyMarket Card',
          ),
        ),
        Dimension.hBox16,

        Column(
          spacing: 4,
          crossAxisAlignment: .start,
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  test.subject.name,
                  style: context.textTheme.sfProW500s20.copyWith(
                    color: context.color.black,
                    fontWeight: FontWeight.w700,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  test.subject.direction.course.faculty.university.name,
                  style: context.textTheme.sfProW500s18.copyWith(color: context.color.gray),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
            Text(
              '${test.subject.direction.name} ${test.academicYearSemesterText}',
              style: context.textTheme.sfProW500s18.copyWith(color: context.color.gray),
              maxLines: 2,
              overflow: .ellipsis,
            ),
            Text(
              '${test.questionCount} ta savol',
              style: context.textTheme.sfProW500s18.copyWith(color: context.color.gray),
              maxLines: 2,
              overflow: .ellipsis,
            ),
            Row(
              spacing: 4,
              children: [
                Lottie.asset(Assets.lottie.money, width: 24, height: 24, repeat: false),
                Text(
                  test.price.toUZSString(),
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

  void onFilterButtonPressed() {
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.color.transparent,
      builder: (ctx) => const FilterBottomSheet(universities: []),
    );
  }
}
