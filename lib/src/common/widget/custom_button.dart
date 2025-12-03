import 'package:flutter/material.dart';

import '../extension/context_extension.dart';
import '../util/dimension.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onRightPressed,
    required this.rightText,
    this.leftButtonType = ButtonType.active,
    this.rightButtonType = ButtonType.active,
    this.onLeftPressed,
    this.leftText,
    super.key,
  });
  final VoidCallback? onLeftPressed;
  final VoidCallback onRightPressed;
  final ButtonType leftButtonType;
  final ButtonType rightButtonType;
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
                backgroundColor: leftButtonType == .active
                    ? context.color.primaryLight.withValues(alpha: 0.1)
                    : context.color.gray.withValues(alpha: 0.1),
                elevation: 0,
                shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll12),
                fixedSize: Size(context.width, 50),
              ),
              onPressed: leftButtonType == ButtonType.active ? onLeftPressed : null,
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
              backgroundColor: rightButtonType == .active
                  ? context.color.primaryLight
                  : context.color.gray.withValues(alpha: 0.1),
              shape: const RoundedRectangleBorder(borderRadius: Dimension.rAll12),
              fixedSize: Size(context.width, 50),
            ),
            onPressed: rightButtonType == ButtonType.active ? onRightPressed : null,
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

enum ButtonType { active, disabled }
