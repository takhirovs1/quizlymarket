import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../../../../common/widget/custom_button.dart';
import '../bloc/test_bloc.dart';
import '../state/university_mode_state.dart';

class UniversityModeScreen extends StatefulWidget {
  const UniversityModeScreen({super.key});

  @override
  State<UniversityModeScreen> createState() => _UniversityModeScreenState();
}

class _UniversityModeScreenState extends UniversityModeState {
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
                  onPressed: () {
                    unselectedCount = 25 - (correctCount + incorrectCount);
                    onTimerEnd();
                  },
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
                  '${state.currentQuestionIndex + 1}/25',
                  style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
                ),
              ],
            ),
            Dimension.hBox14,
            SizedBox(
              height: 44,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: 25,
                separatorBuilder: (context, index) => Dimension.wBox12,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    log('index: $index, revealAnswer: ${isSelected.value[index] != null}');
                    context.read<TestBloc>().add(
                      ChangeQuestionEvent(index: index, revealAnswer: isSelected.value[index] != null),
                    );
                    if (isSelected.value[index] != null) {
                      testResult.value = selectedAnswers[index] ?? 0;
                      context.read<TestBloc>().add(const TestAnswerEvent());
                    } else {
                      testResult.value = 0;
                      context.read<TestBloc>().add(ClearTestEvent(index: index));
                    }
                  },
                  child: AnimatedContainer(
                    width: 40,
                    height: 44,
                    duration: const Duration(milliseconds: 180),
                    decoration: BoxDecoration(
                      color: getColorQuestion(index, state, isBg: true),
                      borderRadius: Dimension.rAll12,
                      border: .all(width: 2, color: getColorQuestion(index, state)),
                    ),
                    alignment: .center,
                    child: Text(
                      '${index + 1}',
                      style: context.textTheme.sfProW500s16.copyWith(
                        color: getColorQuestion(index, state, isText: true),
                      ),
                    ),
                  ),
                ),
              ),
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
                        if (isSelected.value[state.currentQuestionIndex] == null) {
                          testResult.value = i;
                          if (test.answers[testResult.value - 1].isCorrect) {
                            context.telegramWebApp.hapticFeedback.notificationOccurred(.success);
                            correctCount++;
                          } else {
                            context.telegramWebApp.hapticFeedback.notificationOccurred(.error);
                            incorrectCount++;
                          }
                          context.read<TestBloc>().add(const TestAnswerEvent());
                          final newIsSelected = Map<int, bool>.from(isSelected.value);
                          newIsSelected[state.currentQuestionIndex] = test.answers[testResult.value - 1].isCorrect;
                          isSelected.value = newIsSelected;
                          selectedAnswers[state.currentQuestionIndex] = testResult.value;
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
              rightButtonType: value[state.currentQuestionIndex] != null ? .active : .disabled,
              onRightPressed: () {
                if (value[state.currentQuestionIndex] != null) {
                  context.telegramWebApp.hapticFeedback.impactOccurred(.light);
                  onTimerEnd();
                }
              },
              rightText: state.currentQuestionIndex == state.tests.length - 1 ? context.l10n.finish : context.l10n.next,
            ),
          ),
        ),
      );
    },
  );
}
