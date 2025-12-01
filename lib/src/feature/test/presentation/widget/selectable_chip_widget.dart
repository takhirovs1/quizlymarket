import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';
import '../../../../common/util/dimension.dart';
import '../../data/model/test_init_enum.dart';

class SelectableChip extends StatelessWidget {
  const SelectableChip({required this.isSelected, required this.onTap, required this.option, super.key});

  final bool isSelected;
  final VoidCallback onTap;
  final ShuffleOption option;
  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: AnimatedContainer(
      duration: const Duration(milliseconds: 180),
      padding: Dimension.pH12V6,
      decoration: BoxDecoration(
        color: isSelected ? context.color.primary.withValues(alpha: 0.08) : context.color.white,
        borderRadius: Dimension.rAll8,
        border: Border.all(color: isSelected ? context.color.primary : context.color.outline.withValues(alpha: 0.6)),
      ),
      child: Text(
        _shuffleLabel(context, option),
        style: context.textTheme.sfProW500s16.copyWith(color: isSelected ? context.color.primary : context.color.gray),
      ),
    ),
  );
  String _shuffleLabel(BuildContext context, ShuffleOption option) => switch (option) {
    ShuffleOption.all => context.l10n.shuffleAll,
    ShuffleOption.none => context.l10n.shuffleNone,
    ShuffleOption.questionsOnly => context.l10n.shuffleQuestions,
    ShuffleOption.answersOnly => context.l10n.shuffleAnswers,
  };
}
