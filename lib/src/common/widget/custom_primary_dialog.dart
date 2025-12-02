import 'package:flutter/material.dart';

import '../constant/gen/assets.gen.dart';
import '../extension/context_extension.dart';
import '../util/dimension.dart';  
import 'custom_button.dart';

class CustomPrimaryDialog extends StatelessWidget {
  const CustomPrimaryDialog({
    required this.description,
    required this.onPressed,
    required this.title,
    required this.buttonText,
    super.key,
  });

  final String title;
  final String description;
  final VoidCallback onPressed;
  final String buttonText;

  @override
  Widget build(BuildContext context) => AlertDialog(
    backgroundColor: context.color.background,
    title: Column(
      spacing: 16,
      children: [
        Assets.images.robot.image(width: context.width * 0.5, height: context.height * 0.4, fit: BoxFit.scaleDown),

        // Dimension.hBox16,
        Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: context.textTheme.nunitoW600s24.copyWith(color: context.color.primary, fontWeight: FontWeight.w700),
        ),

        Text(
          description,
          style: context.textTheme.nunitoW500s16.copyWith(color: context.color.black),
          textAlign: TextAlign.center,
        ),

        CustomButton(onRightPressed: onPressed, rightText: buttonText),
      ],
    ),
  );
}
