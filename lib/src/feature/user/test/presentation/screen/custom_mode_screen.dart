import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/router/route_arguments.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_button.dart';
import '../bloc/test_bloc.dart';
import '../state/custom_mode_state.dart';

class CustomModeScreen extends StatefulWidget {
  const CustomModeScreen({super.key});

  @override
  State<CustomModeScreen> createState() => _CustomModeScreenState();
}

class _CustomModeScreenState extends CustomModeState {
  @override
  Widget build(BuildContext context) => BlocBuilder<TestBloc, TestState>(
    builder: (context, state) {
      final test = state.tests[state.currentQuestionIndex];
      return Scaffold(
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
                    overlayColor: .all(context.color.gray.withValues(alpha: 0.1)),
                  ),
                  onPressed: () => context.goNamed(Routes.testResult),
                  child: Text(
                    context.l10n.finish,
                    style: context.textTheme.sfProW500s16.copyWith(color: context.color.gray),
                  ),
                ),
              ],
            ),
            Dimension.hBox20,
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(context.l10n.question, style: context.textTheme.sfProW400s14.copyWith(color: context.color.gray)),
                Text(
                  '${state.currentQuestionIndex + 1}/${state.tests.length}',
                  style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
                ),
              ],
            ),
            Dimension.hBox14,
            Text(test.question, style: context.textTheme.sfProW500s20),
            Dimension.hBox32,
            ValueListenableBuilder(
              valueListenable: testResult,
              builder: (context, value, child) => Column(
                children: [
                  for (int i = 1; i <= test.answers.length; i++) ...[
                    GestureDetector(
                      onTap: () {
                        if (!isSelected.value) {
                          testResult.value = i;
                          context.read<TestBloc>().add(const TestAnswerEvent());
                          isSelected.value = true;
                        }
                      },
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 180),
                        padding: Dimension.pH12V6,
                        decoration: BoxDecoration(
                          color: getColor(i, state, isBg: true),
                          borderRadius: Dimension.rAll8,
                          border: .all(color: getColor(i, state)),
                        ),
                        alignment: .topLeft,
                        child: Text(
                          test.answers[i - 1].answer,
                          style: context.textTheme.sfProW500s16.copyWith(color: getColor(i, state, isText: true)),
                        ),
                      ),
                    ),
                    Dimension.hBox12,
                  ],
                ],
              ),
            ),
          ],
        ),
        bottomNavigationBar: Padding(
          padding: Dimension.pAll16,
          child: ValueListenableBuilder(
            valueListenable: isSelected,
            builder: (context, value, child) => CustomButton(
              rightButtonType: value ? .active : .disabled,
              onRightPressed: () {
                if (value) {
                  testResult.value = 0;
                  isSelected.value = false;
                  startTimer();
                  context.read<TestBloc>().add(const ClearTestEvent());
                }
                if (state.currentQuestionIndex == state.tests.length - 1) context.goReplacementNamed(Routes.testResult);
              },
              rightText: state.currentQuestionIndex == state.tests.length - 1 ? context.l10n.finish : context.l10n.next,
            ),
          ),
        ),
      );
    },
  );
}
