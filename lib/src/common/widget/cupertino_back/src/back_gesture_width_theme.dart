part of '../cupertino_back_gesture.dart';

// from cupertino_page_route.dart
const double kDefaultBackGestureWidth = 20;

/// Calculates width of area where back swipe gesture is accepted
/// in logical pixels
/// (optionally) based on the screen size
typedef BackGestureWidthGetter = double Function(ValueGetter<Size>);

/// [BackGestureWidthGetter] builders
class BackGestureWidth {
  const BackGestureWidth._();

  /// Always returns same value equals to [width]
  static BackGestureWidthGetter fixed(double width) =>
      (_) => width;

  /// Always returns a value equals to [fraction] of screen width
  static BackGestureWidthGetter fraction(double fraction) =>
      (sizeGetter) => sizeGetter().width * fraction;
}

/// Applies a [backGestureWidth] to descendant widgets.
class BackGestureWidthTheme extends InheritedWidget {
  const BackGestureWidthTheme({required this.backGestureWidth, required super.child, super.key});

  final BackGestureWidthGetter backGestureWidth;

  static final BackGestureWidthGetter _kDefaultTheme = BackGestureWidth.fixed(kDefaultBackGestureWidth);

  static BackGestureWidthGetter of(BuildContext context) {
    final inheritedTheme = context.dependOnInheritedWidgetOfExactType<BackGestureWidthTheme>();
    return inheritedTheme?.backGestureWidth ?? _kDefaultTheme;
  }

  @override
  bool updateShouldNotify(BackGestureWidthTheme oldWidget) => backGestureWidth != oldWidget.backGestureWidth;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty<BackGestureWidthGetter>.has('backGestureWidth', backGestureWidth));
  }
}
