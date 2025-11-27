import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../constant/gen/assets.gen.dart';
import '../extension/context_extension.dart';
import '../util/dimension.dart';
import 'shimmer_widget.dart';

class CachedImageView extends StatelessWidget {
  const CachedImageView({
    required this.imageUrl,
    this.height,
    super.key,
    this.width = double.infinity,
    this.errorWidget,
    this.borderRadius,
  });

  final double? height;
  final double width;
  final String imageUrl;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: borderRadius ?? Dimension.rAll4,
    clipBehavior: Clip.hardEdge,
    child: CachedNetworkImage(
      imageUrl: imageUrl,
      alignment: Alignment.center,
      fit: BoxFit.cover,
      height: height,
      width: width,
      progressIndicatorBuilder: (context, url, downloadProgress) => ShimmerWidget(
        borderRadius: Dimension.rAll4,
        child: SizedBox(width: double.infinity, height: height),
      ),
      errorWidget: (context, url, error) =>
          errorWidget ??
          SizedBox.shrink(
            child: ColoredBox(color: context.color.error, child: Assets.images.placeholder.image()),
          ),
    ),
  );
}
