import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';

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
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Row(
        spacing: 4,
        children: [
          leadingIcon,
          Text(
            leadingTitle,
            style: context.textTheme.sfProW500s18.copyWith(color: context.color.black, fontWeight: FontWeight.w700),
          ),
        ],
      ),
      Text(
        trailingTitle,
        style: context.textTheme.sfProW500s18.copyWith(color: context.color.black, fontWeight: FontWeight.w500),
      ),
    ],
  );
}
