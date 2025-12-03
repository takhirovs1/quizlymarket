import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/widget/dotted_divider.dart';

class ResultInfoWidget extends StatelessWidget {
  const ResultInfoWidget({
    required this.leadingIcon,
    required this.leadingTitle,
    required this.trailingTitle,
    super.key,
  });
  final String leadingTitle;
  final String trailingTitle;
  final Widget leadingIcon;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      Row(
        spacing: 12,
        children: [
          leadingIcon,
          Text(
            leadingTitle,
            style: context.textTheme.sfProW500s18.copyWith(color: context.color.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      Expanded(child: DottedDivider(color: context.color.outline)),
      Text(
        trailingTitle,
        style: context.textTheme.sfProW500s18.copyWith(color: context.color.black, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
