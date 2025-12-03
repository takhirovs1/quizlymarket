import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../data/model/test_init_enum.dart';
import '../../data/model/test_init_model.dart';
import 'selectable_chip_widget.dart';

class CustomModeContent extends StatefulWidget {
  const CustomModeContent({required this.settings, super.key});

  final CustomTestSettings settings;

  @override
  State<CustomModeContent> createState() => _CustomModeContentState();
}

class _CustomModeContentState extends State<CustomModeContent> {
  static const int _minQuestions = 0;
  static const int _maxQuestions = 100;
  static const int _questionStep = 5;

  late final ValueNotifier<QuestionTimeOption> _selectedOption;
  late final ValueNotifier<ShuffleOption> _shuffleOption;
  late final ValueNotifier<RangeValues> _questionRange;

  @override
  void initState() {
    super.initState();
    _selectedOption = ValueNotifier<QuestionTimeOption>(widget.settings.questionTime);
    _shuffleOption = ValueNotifier<ShuffleOption>(widget.settings.shuffleOption);
    _questionRange = ValueNotifier<RangeValues>(widget.settings.questionRange);
  }

  RangeValues _snapRange(RangeValues values) {
    double snap(double v) => (_questionStep * (v / _questionStep).round()).toDouble();
    final start = snap(values.start).clamp(_minQuestions.toDouble(), _maxQuestions.toDouble() - _questionStep);
    final end = snap(values.end).clamp(start + _questionStep, _maxQuestions.toDouble());
    return RangeValues(start, end);
  }

  void _onQuestionTimePressed(QuestionTimeOption option) {
    _selectedOption.value = option;
    widget.settings.questionTime = option;
  }

  void _onShuffleOptionPressed(ShuffleOption option) {
    _shuffleOption.value = option;
    widget.settings.shuffleOption = option;
  }

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
                onTap: () => _onQuestionTimePressed(option),
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
                  onTap: () => _onShuffleOptionPressed(option),
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
                        widget.settings.questionRange = snapped;
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
}
