import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_button.dart';
import '../state/custom_mode_state.dart';

class CustomModeScreen extends StatefulWidget {
  const CustomModeScreen({super.key});

  @override
  State<CustomModeScreen> createState() => _CustomModeScreenState();
}

class _CustomModeScreenState extends CustomModeState {
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
          Text(format(remaining), style: context.textTheme.nunitoW600s24.copyWith(color: context.color.white)),
        ],
      ),
    ),
    body: ListView(
      padding: Dimension.pAll16,
      children: [
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Expanded(
              child: Text('Akademik ko\'nikmalar', style: context.textTheme.sfProW500s22, overflow: .ellipsis),
            ),
            OutlinedButton(
              style: ButtonStyle(
                backgroundColor: .all(context.color.transparent),
                side: .all(BorderSide(color: context.color.background)),
                padding: .all(Dimension.pH12V8),
              ),
              onPressed: () => context.goNamed(Routes.testResult),
              child: Text('Tugatish', style: context.textTheme.sfProW500s16.copyWith(color: context.color.gray)),
            ),
          ],
        ),
        Dimension.hBox20,
        Row(
          mainAxisAlignment: .spaceBetween,
          children: [
            Text('Savol:', style: context.textTheme.sfProW400s14.copyWith(color: context.color.gray)),
            Text('67/100', style: context.textTheme.sfProW400s14.copyWith(color: context.color.gray)),
          ],
        ),
        Dimension.hBox14,
        Text(
          'Касбий компетенциялар қандай ҳолларда иш жойида муваффақиятга эришишга ёрдам беради?',
          style: context.textTheme.sfProW500s18,
        ),
        Dimension.hBox32,
        ValueListenableBuilder(
          valueListenable: testResult,
          builder: (context, value, child) => Column(
            children: [
              for (int i = 1; i <= 4; i++) ...[
                RadioGroup(
                  onChanged: (_) => testResult.value = i,
                  groupValue: testResult.value,
                  child: Row(
                    crossAxisAlignment: .center,
                    children: [
                      Radio(
                        value: i,
                        backgroundColor: .all(context.color.transparent),
                        activeColor: context.color.primary,
                        visualDensity: .adaptivePlatformDensity,
                        side: BorderSide(width: 1, color: context.color.primary),
                        overlayColor: .all(context.color.transparent),
                      ),
                      GestureDetector(
                        onTap: () => testResult.value = i,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: Dimension.pH12V6,
                          decoration: BoxDecoration(
                            color: value == i ? context.color.primary.withValues(alpha: 0.1) : context.color.white,
                            borderRadius: Dimension.rAll8,
                            border: .all(
                              color: value == i ? context.color.primary : context.color.outline.withValues(alpha: 0.6),
                            ),
                          ),
                          alignment: .center,
                          child: Text(
                            'Оммавий ахборот воситалари орқали ёритиш',
                            style: context.textTheme.sfProW500s14.copyWith(
                              color: value == i ? context.color.primary : context.color.gray,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Dimension.hBox20,
              ],
            ],
          ),
        ),
      ],
    ),
    bottomNavigationBar: Padding(
      padding: Dimension.pAll16,
      child: CustomButton(onRightPressed: () {}, rightText: context.l10n.startTest),
    ),
  );
}
