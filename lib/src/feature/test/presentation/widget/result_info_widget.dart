import 'package:flutter/material.dart';

import '../../../../common/extension/context_extension.dart';

class ResultInfoWidget extends StatelessWidget {
  const ResultInfoWidget({
    required this.leadingIcon,
    required this.leadingTitle,
    required this.trailingTitle,
    super.key,
    this.trailingIcon,
  });
  final String leadingTitle;
  final String trailingTitle;
  final Widget leadingIcon;
  final Widget? trailingIcon;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        spacing: 4,
        children: [
          leadingIcon,
          Text(leadingTitle, style: context.textTheme.sfProW600s16),
        ],
      ),
      Row(
        spacing: 4,
        children: [
          if (trailingIcon != null) trailingIcon!,
          Text(trailingTitle, style: context.textTheme.sfProW600s16),
        ],
      ),
    ],
  );
}
