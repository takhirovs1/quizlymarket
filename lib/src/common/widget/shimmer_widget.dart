import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../util/dimension.dart';

class ShimmerWidget extends StatelessWidget {
  const ShimmerWidget({
    required this.child,
    super.key,
    this.height = 100.0,
    this.width = double.infinity,
    this.borderRadius = Dimension.rAll16,
  });

  final double height;
  final double width;
  final BorderRadius borderRadius;
  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: width,
    height: height,
    child: Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: DecoratedBox(
        decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: borderRadius),
      ),
    ),
  );
}
