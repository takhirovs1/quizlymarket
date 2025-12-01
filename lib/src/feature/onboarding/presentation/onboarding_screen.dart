import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constant/gen/assets.gen.dart';
import '../../../common/extension/context_extension.dart';
import '../../../common/router/route_arguments.dart';
import '../../../common/util/dimension.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: context.color.primary,
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
                  style: context.textTheme.nunitoW500s10.copyWith(
                    fontSize: 50,
                    color: context.color.white,
                  ),
                ),
                Dimension.hBox64,
                Assets.images.logoPng.image(),
              ],
            ),
          ),
          ElevatedButton(
            style: const ButtonStyle(
              padding: WidgetStatePropertyAll(Dimension.pV16),
            ),
            onPressed: () async {
              // await context.localSource.setOnboardingCompleted(true);
              if (!context.mounted) return;
              context.go(Routes.home); // yoki goNamed bo‘lsa name bilan
            },
            child: Text(
              'Start'.toUpperCase(),
              style: context.textTheme.nunitoW500s20.copyWith(
                fontWeight: .w900,
                color: context.color.primary,
              ),
            ),
          ),
          Dimension.hBox20,
          Text(
            'Copyright © 2025 FlutterBro',
            style: context.textTheme.nunitoW600s12.copyWith(
              fontWeight: .w900,
              color: context.color.white,
            ),
            textAlign: .center,
          ),
          Dimension.hBox24,
        ],
      ),
    ),
  );
}
