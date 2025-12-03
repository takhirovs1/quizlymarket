import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:vector_graphics/vector_graphics.dart';

import '../../constant/gen/fonts.gen.dart';
import '../../extension/context_extension.dart';
import '../../theme/theme_data.dart';
import '../../util/dimension.dart';

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
    final theme = View.of(context).platformDispatcher.platformBrightness == .light
        ? AppThemeData.light(FontFamily.nunito)
        : AppThemeData.dark(FontFamily.nunito);

    return Material(
      color: theme.appColors.white,
      child: Directionality(
        textDirection: .ltr,
        child: Scaffold(
          backgroundColor: const Color(0xff1C58F2),
          bottomNavigationBar: const Padding(
            padding: Dimension.pBottom32,
            child: CircularProgressIndicator.adaptive(strokeWidth: 2),
          ),
          body: Center(
            child: SizedBox(width: context.width * 0.5, height: context.width * 0.5, child: _buildLogo()),
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
  late Animation<double> opacityAnimation;

  Widget _buildLogo() {
    final logoPath = widget.logo?.path;
    if (logoPath == null || logoPath.isEmpty) return const SizedBox.shrink();

    final normalizedPath = logoPath.toLowerCase();

    if (normalizedPath.endsWith('.vec')) {
      return SvgPicture(AssetBytesLoader(logoPath));
    }

    if (normalizedPath.endsWith('.svg')) {
      return SvgPicture.asset(logoPath);
    }

    return Image.asset(logoPath);
  }

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
