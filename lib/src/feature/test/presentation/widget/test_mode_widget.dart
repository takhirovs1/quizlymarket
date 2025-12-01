import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';
import '../../data/model/test_init_enum.dart';
import 'selectable_chip_widget.dart';

class TestModeWidget extends StatefulWidget {
  const TestModeWidget({super.key});

  @override
  State<TestModeWidget> createState() => _TestModeWidgetState();
}

class _TestModeWidgetState extends State<TestModeWidget> {
  final ValueNotifier<TestMode> _selectedTestMode = ValueNotifier(TestMode.custom);

  void _onModePressed(TestMode mode) {
    if (_selectedTestMode.value == mode) return;
    _selectedTestMode.value = mode;
  }

  @override
  void dispose() {
    _selectedTestMode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      Text(
        context.l10n.parameters,
        style: context.textTheme.sfProW500s16.copyWith(color: context.color.black, fontWeight: FontWeight.w700),
      ),
      Text(context.l10n.testModeLabel, style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray)),
      Dimension.hBox8,
      ValueListenableBuilder<TestMode>(
        valueListenable: _selectedTestMode,
        builder: (context, mode, _) => Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 4,
              children: [
                SizedBox(
                  height: 36,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      padding: Dimension.pH12V8,
                      backgroundColor: mode == TestMode.custom ? context.color.primary : context.color.white,
                    ),
                    onPressed: () => _onModePressed(TestMode.custom),
                    child: Text(
                      context.l10n.testModeCustom,
                      style: context.textTheme.sfProW500s16.copyWith(
                        color: mode == TestMode.custom ? context.color.white : context.color.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      padding: Dimension.pH12V8,
                      backgroundColor: mode == TestMode.university ? context.color.primary : context.color.white,
                    ),
                    onPressed: () => _onModePressed(TestMode.university),
                    child: Text(
                      context.l10n.testModeUniversity,
                      style: context.textTheme.sfProW500s16.copyWith(
                        color: mode == TestMode.university ? context.color.white : context.color.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Dimension.hBox16,
            switch (mode) {
              TestMode.custom => const CustomModeContent(),
              TestMode.university => const UniversityModeContent(),
            },
          ],
        ),
      ),
    ],
  );
}

class CustomModeContent extends StatefulWidget {
  const CustomModeContent({super.key});

  @override
  State<CustomModeContent> createState() => _CustomModeContentState();
}

class _CustomModeContentState extends State<CustomModeContent> {
  static const int _minQuestions = 0;
  static const int _maxQuestions = 100;
  static const int _questionStep = 5;

  final ValueNotifier<QuestionTimeOption> _selectedOption = ValueNotifier(QuestionTimeOption.seconds15);
  final ValueNotifier<ShuffleOption> _shuffleOption = ValueNotifier(ShuffleOption.all);
  final ValueNotifier<RangeValues> _questionRange = ValueNotifier(
    RangeValues(_minQuestions.toDouble(), _maxQuestions.toDouble()),
  );

  @override
  void dispose() {
    _selectedOption.dispose();
    _shuffleOption.dispose();
    _questionRange.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      Text(
        context.l10n.testModeQuestionTime,
        style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
      ),
      Dimension.hBox8,
      SizedBox(
        height: 32,
        child: ValueListenableBuilder<QuestionTimeOption>(
          valueListenable: _selectedOption,
          builder: (context, selected, _) => ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemCount: QuestionTimeOption.values.length,
            separatorBuilder: (_, _) => Dimension.wBox8,
            itemBuilder: (context, index) {
              final option = QuestionTimeOption.values[index];
              final isSelected = option == selected;
              return GestureDetector(
                onTap: () => _selectedOption.value = option,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  padding: Dimension.pH12V6,
                  decoration: BoxDecoration(
                    color: isSelected ? context.color.primary.withValues(alpha: 0.1) : context.color.white,
                    borderRadius: Dimension.rAll8,
                    border: Border.all(
                      color: isSelected ? context.color.primary : context.color.outline.withValues(alpha: 0.6),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    option.label,
                    style: context.textTheme.sfProW500s14.copyWith(
                      color: isSelected ? context.color.primary : context.color.gray,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      Dimension.hBox16,
      Text(
        context.l10n.changeQuestionOrAnswer,
        style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
      ),
      Dimension.hBox8,
      ValueListenableBuilder<ShuffleOption>(
        valueListenable: _shuffleOption,
        builder: (context, selected, _) => Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ShuffleOption.values
              .map(
                (option) => SelectableChip(
                  option: option,
                  isSelected: option == selected,
                  onTap: () => _shuffleOption.value = option,
                ),
              )
              .toList(),
        ),
      ),
      Dimension.hBox16,
      Text(
        context.l10n.selectQuestionByRange,
        style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
      ),
      Dimension.hBox8,
      ValueListenableBuilder<RangeValues>(
        valueListenable: _questionRange,
        builder: (context, range, _) => Column(
          children: [
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  '${range.start.toInt()}',
                  style: context.textTheme.sfProW500s16.copyWith(
                    color: context.color.gray,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
                Flexible(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      trackHeight: 6,
                      activeTrackColor: context.color.primary,
                      inactiveTrackColor: context.color.outline.withValues(alpha: 0.25),
                      thumbColor: context.color.white,
                      overlayColor: context.color.primary.withValues(alpha: 0.12),
                      thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14),
                      overlayShape: const RoundSliderOverlayShape(overlayRadius: 24),
                    ),
                    child: RangeSlider(
                      values: range,
                      min: _minQuestions.toDouble(),
                      max: _maxQuestions.toDouble(),
                      // divisions: (_maxQuestions - _minQuestions) ~/ _questionStep,
                      // labels: RangeLabels('${range.start.toInt()}', '${range.end.toInt()}'),
                      onChanged: (value) {
                        final snapped = _snapRange(value);
                        if (snapped.end - snapped.start < _questionStep) return;
                        _questionRange.value = snapped;
                      },
                    ),
                  ),
                ),
                Text(
                  '${range.end.toInt()}',
                  style: context.textTheme.sfProW500s16.copyWith(
                    color: context.color.gray,
                    fontWeight: FontWeight.w700,
                    fontSize: 17,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  );

  RangeValues _snapRange(RangeValues values) {
    double snap(double v) => (_questionStep * (v / _questionStep).round()).toDouble();
    final start = snap(values.start).clamp(_minQuestions.toDouble(), _maxQuestions.toDouble() - _questionStep);
    final end = snap(values.end).clamp(start + _questionStep, _maxQuestions.toDouble());
    return RangeValues(start, end);
  }
}

class UniversityModeContent extends StatefulWidget {
  const UniversityModeContent({super.key});

  @override
  State<UniversityModeContent> createState() => _UniversityModeContentState();
}

class _UniversityModeContentState extends State<UniversityModeContent> {
  final ValueNotifier<TotalTestTimeOption> _selectedTotalTime = ValueNotifier(TotalTestTimeOption.minutes30);

  @override
  void dispose() {
    _selectedTotalTime.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      Text(context.l10n.allOfTimeTest, style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray)),
      Dimension.hBox8,
      ValueListenableBuilder<TotalTestTimeOption>(
        valueListenable: _selectedTotalTime,
        builder: (context, selected, _) => Row(
          spacing: 8,
          mainAxisSize: .min,
          children: TotalTestTimeOption.values
              .map(
                (option) => GestureDetector(
                  onTap: () => _selectedTotalTime.value = option,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 180),
                    height: 36,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: option == selected ? context.color.primary : context.color.white,
                      borderRadius: Dimension.rAll8,
                      border: Border.all(
                        color: option == selected ? context.color.primary : context.color.outline.withValues(alpha: .6),
                      ),
                    ),
                    child: Padding(
                      padding: Dimension.pH12V6,
                      child: Text(
                        _totalTimeLabel(context, option),
                        style: context.textTheme.sfProW500s16.copyWith(
                          color: option == selected ? context.color.white : context.color.gray,
                        ),
                      ),
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
      Dimension.hBox16,
      Text(
        context.l10n.questionRangeHint(100),
        style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray),
      ),
    ],
  );

  String _totalTimeLabel(BuildContext context, TotalTestTimeOption option) => switch (option) {
    TotalTestTimeOption.minutes30 => context.l10n.testTotalTime30Min,
    TotalTestTimeOption.hour1 => context.l10n.testTotalTime1Hour,
  };
}
