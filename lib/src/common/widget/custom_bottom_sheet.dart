import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import '../util/dimension.dart';

class CustomBottomSheet extends StatelessWidget {
  const CustomBottomSheet({
    required this.children,
    this.initialChildSize = .5,
    super.key,
    this.maxChildSize = .9,
    this.isScrollable = true,
  });
  final List<Widget> children;
  final double initialChildSize;
  final double maxChildSize;
  final bool isScrollable;

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: initialChildSize,
    minChildSize: initialChildSize,
    maxChildSize: maxChildSize,
    expand: false,

    builder: (ctx, scrollController) => Column(
      children: [
        Center(
          child: Container(
            width: 44,
            height: 5,
            margin: Dimension.pBottom8,
            decoration: BoxDecoration(color: context.color.gray, borderRadius: BorderRadius.circular(100)),
          ),
        ),
        Expanded(
          child: DecoratedBox(
            decoration: BoxDecoration(color: context.color.background, borderRadius: Dimension.rTop16),
            child: ListView(
              physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
              controller: scrollController,
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),

              children: children,
            ),
          ),
        ),
      ],
    ),
  );
}
