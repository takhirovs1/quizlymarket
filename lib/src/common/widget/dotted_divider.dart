import 'package:flutter/material.dart';

import '../util/dimension.dart';

class DottedDivider extends StatelessWidget {
  const DottedDivider({required this.color, super.key});

  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
    padding: Dimension.pH8,
    child: SizedBox(
      height: 8,
      child: LayoutBuilder(
        builder: (context, constraints) {
          const dashWidth = 4.0;
          const dashSpace = 4.0;
          final dashCount = (constraints.maxWidth / (dashWidth + dashSpace)).floor();
          if (dashCount <= 0) return const SizedBox.shrink();
    
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              dashCount,
              (_) => SizedBox(
                width: dashWidth,
                height: 1,
                child: DecoratedBox(decoration: BoxDecoration(color: color)),
              ),
            ),
          );
        },
      ),
    ),
  );
}
