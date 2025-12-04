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
    this.bottomNavigationBar,
    this.title,
  });
  final List<Widget> children;
  final double initialChildSize;
  final double maxChildSize;
  final bool isScrollable;
  final Widget? bottomNavigationBar;
  final Widget? title;

  @override
  Widget build(BuildContext context) => DraggableScrollableSheet(
    initialChildSize: initialChildSize,
    minChildSize: initialChildSize,
    maxChildSize: maxChildSize,
    expand: false,

    builder: (ctx, scrollController) => Scaffold(
      backgroundColor: context.color.transparent,
      bottomNavigationBar: switch (bottomNavigationBar) {
        null => null,
        Widget widget => ColoredBox(
          color: context.color.white,
          child: SafeArea(
            child: Padding(padding: Dimension.pAll16, child: widget),
          ),
        ),
      },
      body: Column(
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
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                child: Column(
                  crossAxisAlignment: .start,
                  children: [
                    if (title != null) ...[title!, Dimension.hBox16],
                    Dimension.hBox16,
                    Expanded(
                      child: ListView(
                        physics: isScrollable ? null : const NeverScrollableScrollPhysics(),
                        controller: scrollController,

                        children: children,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
