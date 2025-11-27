import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../constant/gen/fonts.gen.dart';
import '../../theme/theme_data.dart';

/// {@template splash_screen}
/// Splash screen widget.
/// {@endtemplate}
class SplashScreen extends StatefulWidget {
  /// {@macro splash_screen}
  const SplashScreen({required this.logo, required this.progress, super.key});

  /// Logo to display.
  final ({String path, double scale})? logo;

  /// Progress notifier.
  final ValueNotifier<({int progress, String message})> progress;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends SplashController {
  @override
  Widget build(BuildContext context) {
    final theme = View.of(context).platformDispatcher.platformBrightness == Brightness.light
        ? AppThemeData.light(FontFamily.workSans)
        : AppThemeData.dark(FontFamily.workSans);

    return Material(
      color: theme.appColors.white,
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Scaffold(
            backgroundColor: colorAnimation.value,
            body: Center(
              child: AnimatedBuilder(
                animation: animation,
                builder: (context, child) => Opacity(
                  opacity: opacityAnimation.value,
                  child: Transform.scale(key: const Key('splash_screen_logo'), scale: animation.value, child: child),
                ),
                child: Transform.scale(
                  scale: widget.logo?.scale ?? 1,
                  child: SvgPicture(AssetBytesLoader(widget.logo?.path ?? '')),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// --- Splash screen controller --- ///
/// {@template splash_controller}
/// Splash screen controller.
/// {@endtemplate}
abstract class SplashController extends State<SplashScreen> with SingleTickerProviderStateMixin {
  SvgPicture? svgImage;
  double logoScale = 1;
  bool _vibrated = false;

  late AnimationController controller;
  late Animation<double> animation;
  late Animation<Color?> colorAnimation;
  late Animation<double> opacityAnimation;

  void _providePreciseHapticFeedback() {
    if (controller.value > 0.2 && !_vibrated) {
      HapticFeedback.mediumImpact();
      _vibrated = true;
    }
  }

  void _onAppInitializedListener() {
    if (widget.progress.value.progress == 100) {
      controller.forward();
    }
  }

  // --- Lifecycle --- //
  @override
  void initState() {
    super.initState();

    widget.progress.addListener(_onAppInitializedListener);

    controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000));
    animation = Tween<double>(begin: 1, end: 15).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    colorAnimation = ColorTween(
      begin: Colors.blueAccent,
      end: Colors.transparent,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    opacityAnimation = Tween<double>(
      begin: 1,
      end: 0,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeIn));

    controller.addListener(_providePreciseHapticFeedback);
  }

  @override
  void dispose() {
    controller.dispose();
    widget.progress.removeListener(_onAppInitializedListener);
    super.dispose();
  }

  // --- End of Lifecycle --- //
}
