import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import '../util/dimension.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onRightPressed,
    required this.rightText,
    this.onLeftPressed,
    this.leftText,
    super.key,
  });
  final VoidCallback? onLeftPressed;
  final VoidCallback onRightPressed;
  final String? leftText;
  final String rightText;

  @override
  Widget build(BuildContext context) => Padding(
    padding: Dimension.pBottom10,
    child: Row(
      mainAxisAlignment: .spaceBetween,
      spacing: 12,
      children: [
        if (leftText != null)
          Flexible(
            child: FilledButton(
              style: FilledButton.styleFrom(
                padding: Dimension.pH12V8,
                backgroundColor: context.color.primaryLight.withValues(alpha: 0.1),
                elevation: 0,
                shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll12),
                fixedSize: Size(context.width, 50),
              ),
              onPressed: onLeftPressed,
              child: Text(
                leftText ?? '',
                style: context.textTheme.sfProW500s16.copyWith(
                  color: context.color.primaryLight,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        Flexible(
          child: FilledButton(
            style: FilledButton.styleFrom(
              padding: Dimension.pH12V8,
              backgroundColor: context.color.primaryLight,
              shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll12),
              fixedSize: Size(context.width, 50),
            ),
            onPressed: onRightPressed,
            child: Center(
              child: Text(
                rightText,
                style: context.textTheme.sfProW500s16.copyWith(
                  color: context.color.white,
                  fontWeight: FontWeight.w700,
                  fontSize: 17,
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
