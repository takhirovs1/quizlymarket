import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';

class TestInfoWidget extends StatelessWidget {
  const TestInfoWidget({
    required this.subject,
    required this.university,
    required this.direction,
    required this.testCount,
    super.key,
  });

  final String subject;
  final String university;
  final String direction;
  final int testCount;
  @override
  Widget build(BuildContext context) => Column(
    spacing: 4,
    crossAxisAlignment: .start,
    children: [
      Row(
        spacing: 4,
        mainAxisAlignment: .spaceBetween,
        children: [
          Flexible(
            child: Text(
              subject,
              maxLines: 1,
              overflow: .ellipsis,
              style: context.textTheme.sfProW500s22.copyWith(color: context.color.black),
            ),
          ),
          Text(
            university,
            maxLines: 1,
            overflow: .ellipsis,
            style: context.textTheme.sfProW500s16.copyWith(color: context.color.gray),
          ),
        ],
      ),
      Text(direction, style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray)),
      Text('$testCount ta savol', style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray)),
    ],
  );
}
