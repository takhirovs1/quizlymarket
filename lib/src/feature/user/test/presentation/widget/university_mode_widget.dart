import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../data/model/test_init_enum.dart';

class UniversityModeContent extends StatefulWidget {
  const UniversityModeContent({required this.settings, super.key});

  final CustomTestSettings settings;

  @override
  State<UniversityModeContent> createState() => _UniversityModeContentState();
}

class _UniversityModeContentState extends State<UniversityModeContent> {
  late final ValueNotifier<TotalTestTimeOption> _selectedTotalTime;

  @override
  void initState() {
    super.initState();
    _selectedTotalTime = ValueNotifier(widget.settings.totalTestTime);
  }

  @override
  void dispose() {
    _selectedTotalTime.dispose();
    super.dispose();
  }

  void _onTotalTimePressed(TotalTestTimeOption option) {
    _selectedTotalTime.value = option;
    widget.settings.totalTestTime = option;
  }

  String _totalTimeLabel(BuildContext context, TotalTestTimeOption option) => switch (option) {
    TotalTestTimeOption.minutes30 => context.l10n.testTotalTime30Min,
    TotalTestTimeOption.hour1 => context.l10n.testTotalTime1Hour,
  };

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
                  onTap: () => _onTotalTimePressed(option),
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
}
