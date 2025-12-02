import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_button.dart';
import '../state/test_init_state.dart';
import '../widget/test_info_widget.dart';
import '../widget/test_mode_widget.dart';

class TestInitScreen extends StatefulWidget {
  const TestInitScreen({super.key});

  @override
  State<TestInitScreen> createState() => _TestInitScreenState();
}

class _TestInitScreenState extends TestInitState {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.white,
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
            child: Text(context.l10n.test, style: context.textTheme.nunitoW600s24.copyWith(color: context.color.white)),
          ),
        ],
      ),
    ),
    bottomNavigationBar: Padding(
      padding: Dimension.pAll16,
      child: CustomButton(onRightPressed: onOpenTestScreen, rightText: context.l10n.startTest),
    ),
    body: ListView(
      padding: Dimension.pAll16,
      children: [
        const TestInfoWidget(
          subject: 'Akademik ko\'nikmalar',
          university: 'Alfraganus',
          direction: 'Iqtisodiyot sirtqi 2-kurs 2-semistr',
          testCount: 100,
        ),
        Dimension.hBox14,
        TestModeWidget(selectedMode: selectedTestMode, onModeChanged: updateTestMode, settingsNotifier: testSettings),
      ],
    ),
  );
}
