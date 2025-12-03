import 'package:flutter/material.dart';

import '../../../../common/constant/gen/assets.gen.dart';
import '../../../../common/extension/context_extension.dart';
import '../../../../common/router/route_arguments.dart';
import '../../../../common/util/dimension.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  bool _redirectScheduled = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _maybeRedirect();
  }

  @override
  Widget build(BuildContext context) {
    if (_redirectScheduled) {
      return const Scaffold(body: Center(child: CircularProgressIndicator.adaptive()));
    }

    return Scaffold(
      backgroundColor: const Color(0xff1C58F2),
      body: Padding(
        padding: Dimension.pH32,
        child: Column(
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: .center,
                children: [
                  Text(
                    'QuizlyMarket',
                    style: context.textTheme.nunitoW500s10.copyWith(fontSize: 50, color: context.color.white),
                  ),
                  Dimension.hBox64,
                  Assets.images.logoPng.image(
                    width: context.width * 0.7,
                    height: context.width * 0.7,
                    fit: BoxFit.scaleDown,
                  ),
                ],
              ),
            ),
            FilledButton(
              style: FilledButton.styleFrom(backgroundColor: context.color.white, padding: Dimension.pV16),
              onPressed: _completeOnboarding,
              child: Text(
                'Start'.toUpperCase(),
                style: context.textTheme.nunitoW500s20.copyWith(fontWeight: .w900, color: context.color.primary),
              ),
            ),
            Dimension.hBox20,
            Text(
              'Copyright © 2025 FlutterBro',
              style: context.textTheme.nunitoW600s12.copyWith(fontWeight: .w900, color: context.color.white),
              textAlign: .center,
            ),
            Dimension.hBox24,
          ],
        ),
      ),
    );
  }

  Future<void> _completeOnboarding() async {
    await context.localSource.setOnboardingCompleted(true);
    if (!mounted) return;
    await Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
  }

  void _maybeRedirect() {
    if (_redirectScheduled) return;
    if (!context.localSource.onboardingCompleted) return;

    _redirectScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      if (!context.mounted) return;
      await Navigator.of(context).pushNamedAndRemoveUntil(Routes.home, (route) => false);
    });
  }
}
