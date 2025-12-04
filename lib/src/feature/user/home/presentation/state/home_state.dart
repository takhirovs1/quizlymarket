import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:telegram_web_app/telegram_web_app.dart';

import '../../../../../common/constant/gen/assets.gen.dart';
import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/extension/int_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/util/logger.dart';
import '../../../../../common/widget/custom_bottom_sheet.dart';
import '../../../../../common/widget/custom_button.dart';
import '../../../../../common/widget/custom_primary_dialog.dart';
import '../../../profile/presentation/widget/bank_card_widget.dart';
import '../../data/model/home_default_model.dart';
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

  Future<void> onBuyButtonPressed() async => await showModalBottomSheet<void>(
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
                  'Akademik ko\'nikmalar',
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

  void onFilterButtonPressed() {
    showModalBottomSheet<void>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: context.color.transparent,
      builder: (ctx) => FilterBottomSheet(universities: universities),
    );
  }

  List<UniversityModel> universities = <UniversityModel>[
    UniversityModel(
      id: 'u1',
      name: 'Alfraganus',

      faculties: [
        FacultyModel(id: 'f_all', name: 'Barcha Fakultetlar'),
        FacultyModel(
          id: 'f1',
          name: 'Faculty of Economics',
          courses: [
            CourseModel(id: 'c_all', name: 'Barcha kurslar'),
            CourseModel(id: 'c1', name: '1-kurs'),
            CourseModel(id: 'c2', name: '2-kurs'),
            CourseModel(id: 'c3', name: '3-kurs'),
            CourseModel(id: 'c4', name: '4-kurs'),
            CourseModel(
              id: 'c1_sirtqi',
              name: '1-kurs sirtqi',
              directions: [
                DirectionModel(id: 'd_all', name: 'Barcha yo’nalishlar'),
                DirectionModel(id: 'd1', name: 'Economy'),
                DirectionModel(id: 'd2', name: 'World economy and international econ...'),
                DirectionModel(id: 'd3', name: 'Finance and financial technologies'),
                DirectionModel(id: 'd4', name: 'Taxes and taxation'),
                DirectionModel(id: 'd5', name: 'Accounting'),
              ],
            ),
            CourseModel(id: 'c2_sirtqi', name: '2-kurs sirtqi'),
            CourseModel(id: 'c1_kechki', name: '1-kurs kechki'),
            CourseModel(id: 'c2_kechki', name: '2-kurs kechki'),
          ],
        ),
        FacultyModel(id: 'f2', name: 'Faculty of Medicine'),
        FacultyModel(id: 'f3', name: 'Faculty of Social Sciences'),
        FacultyModel(id: 'f4', name: 'Faculty of Philology'),
      ],
    ),
    UniversityModel(id: 'u2', name: 'Toshkent davlat Iqtisodiyot University'),
    UniversityModel(id: 'u3', name: 'Toshkent davlat Yuridik University'),
    UniversityModel(id: 'u4', name: 'WUIT'),
  ];
}
