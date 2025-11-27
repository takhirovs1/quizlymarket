import 'package:flutter/material.dart';

import '../../extension/context_extension.dart';

/// {@template haptic_button}
/// Button that provides haptic feedback.
/// {@endtemplate}
final class HapticButton extends StatelessWidget {
  /// {@macro haptic_button}
  const HapticButton({required this.child, this.feedback, this.onTap, this.color, super.key});

  final Widget child;
  final Color? color;
  final void Function()? onTap;

  /// If you want to use custom haptic feedback, you can use this parameter.
  /// For example, you can use this parameter to use custom haptic feedback for a specific button.
  ///
  /// ```dart
  /// HapticButton(
  ///   feedback: () => HapticFeedback.heavyImpact(),
  ///   child: Text('Button'),
  /// )
  ///
  final void Function()? feedback;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      onTap?.call();
      feedback?.call();
    },
    child: ColoredBox(color: color ?? context.color.transparent, child: child),
  );
}
