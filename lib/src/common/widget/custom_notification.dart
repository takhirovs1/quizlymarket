import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

/// A widget that displays a notification message on the screen.
///
/// Features:
/// - Appears temporarily and disappears automatically after a set duration
/// - Can be dismissed by tapping on it
/// - Customizable appearance (background color, text style, border radius)
/// - Supports an optional icon
/// - Can be positioned at different locations on the screen
/// - Can add a callback to be called when the notification is tapped
///
/// Example usage:
/// ```dart
/// CustomNotification.show(
///   context: context,
///   message: 'Hello, world!',
/// );
/// ```
///
/// or using the context extension:
/// ```dart
/// context.showCustomNotification(
///   message: 'Hello, world!',
/// );
/// ```
class CustomNotification extends StatefulWidget {
  /// Constructor for the [CustomNotification] widget.
  const CustomNotification({
    required this.message,
    required this.textStyle,
    required this.radius,
    super.key,
    this.backgroundColor = Colors.black87,
    this.duration = const Duration(seconds: 3),
    this.icon,
    this.testMode = false,
    this.padding,
    this.onNotificationTap,
  });

  /// The message to display in the notification.
  final String message;

  /// The background color of the notification.
  final Color backgroundColor;

  /// The text style of the notification.
  final TextStyle textStyle;

  /// The duration of the notification.
  final Duration duration;

  /// The radius of the notification.
  final BorderRadius radius;

  /// The icon to display in the notification.
  final Widget? icon;

  /// The padding of the notification.
  final EdgeInsets? padding;

  /// The callback to be called when the notification is tapped.
  final void Function()? onNotificationTap;

  /// Whether the notification is in test mode.
  final bool testMode;

  static OverlayEntry? _currentOverlay;

  /// Static method to show a notification.
  static OverlayEntry? show({
    required BuildContext context,
    required String message,
    Color? backgroundColor,
    TextStyle? textStyle,
    Duration? duration,
    Widget? icon,
    BorderRadius? radius,
    EdgeInsets? padding,
    void Function()? onNotificationTap,
    bool testMode = false,
  }) {
    _currentOverlay?.remove();
    _currentOverlay = null;

    final overlayState = Overlay.of(context);
    OverlayEntry? overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) => CustomNotification(
        message: message,
        backgroundColor: backgroundColor ?? const Color(0xFF17B26A),
        textStyle: textStyle ?? context.textTheme.workSansW400s14.copyWith(color: context.color.white),
        duration: duration ?? const Duration(seconds: 3),
        icon: icon,
        radius: radius ?? const BorderRadius.all(Radius.circular(64)),
        padding: padding,
        testMode: testMode,
        onNotificationTap: onNotificationTap,
      ),
    );

    _currentOverlay = overlayEntry;
    overlayState.insert(overlayEntry);

    return overlayEntry;
  }

  /// Method to hide the current notification.
  static void hideCurrentNotification() {
    _currentOverlay?.remove();
    _currentOverlay = null;
  }

  @override
  State<CustomNotification> createState() => _CustomNotificationState();
}

class _CustomNotificationState extends State<CustomNotification> with SingleTickerProviderStateMixin {
  late Animation<double> _fadeAnimation;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(duration: const Duration(milliseconds: 150), vsync: this);

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _animationController, curve: Curves.easeIn, reverseCurve: Curves.easeOut));

    _animationController.forward();

    if (!widget.testMode) {
      Future<void>.delayed(widget.duration - const Duration(milliseconds: 150), () {
        if (mounted) {
          _animationController.reverse().then((_) {
            CustomNotification._currentOverlay?.remove();
            CustomNotification._currentOverlay = null;
          });
        }
      });
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Stack(
    children: <Widget>[
      Positioned(
        top: MediaQuery.paddingOf(context).top + 15,
        left: 0,
        right: 0,
        child: GestureDetector(
          onTap: widget.onNotificationTap ?? CustomNotification.hideCurrentNotification,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Center(
              child: Material(
                color: Colors.transparent,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: widget.backgroundColor,
                    borderRadius: widget.radius,
                    boxShadow: const <BoxShadow>[
                      BoxShadow(color: Colors.black26, blurRadius: 10, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Padding(
                    padding: widget.padding ?? const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                    child: switch (widget.icon == null) {
                      true => Text(
                        widget.message,
                        style: widget.textStyle,
                        softWrap: true,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                      ),
                      false => Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          widget.icon ?? const SizedBox.shrink(),

                          const SizedBox(width: 8),

                          Text(
                            widget.message,
                            style: widget.textStyle,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ],
                      ),
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
