import 'package:flutter/material.dart';

import '../constant/gen/assets.gen.dart';
import '../extension/context_extension.dart';
import '../util/dimension.dart';

class CustomPrimaryDialog extends StatelessWidget {
  const CustomPrimaryDialog({required this.description, required this.onPressed, required this.title, super.key});

  final String title;
  final String description;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) => AlertDialog(
    backgroundColor: context.color.background,
    title: Column(
      spacing: 16,
      children: [
        Stack(
          children: [
            Assets.images.backgroundImage.image(width: 190, height: 180),
            Positioned(child: Assets.images.robot.image(width: 190, height: 180)),
          ],
        ),

        Dimension.hBox16,

        Text(title, style: context.textTheme.sfProW600s24.copyWith(color: context.color.primary)),

        Text(description, style: context.textTheme.sfProW400s16.copyWith(color: context.color.black)),

        FilledButton(
          style: FilledButton.styleFrom(
            shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll12),
            padding: Dimension.pH32V14,
            backgroundColor: context.color.primary,
          ),

          onPressed: onPressed,
          child: Text(
            context.l10n.enterTest,
            style: context.textTheme.sfProW500s14.copyWith(color: context.color.white),
          ),
        ),
      ],
    ),
  );
}
