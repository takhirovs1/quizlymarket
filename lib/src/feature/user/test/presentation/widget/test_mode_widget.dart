import 'package:flutter/material.dart';

import '../../../../../common/extension/context_extension.dart';
import '../../../../../common/util/dimension.dart';
import '../../data/model/test_init_enum.dart';
import '../../data/model/test_init_model.dart';
import 'custom_mode_widget.dart';
import 'university_mode_widget.dart';

class TestModeWidget extends StatelessWidget {
  const TestModeWidget({
    required this.selectedMode,
    required this.onModeChanged,
    required this.settingsNotifier,
    super.key,
  });

  final ValueNotifier<TestMode> selectedMode;
  final ValueChanged<TestMode> onModeChanged;
  final ValueNotifier<CustomTestSettings> settingsNotifier;

  void _onModePressed(TestMode mode) => onModeChanged(mode);

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: .start,
    children: [
      Text(
        context.l10n.parameters,
        style: context.textTheme.sfProW500s16.copyWith(color: context.color.black, fontWeight: .w700),
      ),
      Text(context.l10n.testModeLabel, style: context.textTheme.sfProW400s16.copyWith(color: context.color.gray)),
      Dimension.hBox8,
      ValueListenableBuilder<TestMode>(
        valueListenable: selectedMode,
        builder: (context, mode, _) => Column(
          crossAxisAlignment: .start,
          children: [
            Row(
              spacing: 4,
              children: [
                SizedBox(
                  height: 36,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      padding: Dimension.pH12V8,
                      backgroundColor: mode == .custom ? context.color.primary : context.color.white,
                    ),
                    onPressed: () => _onModePressed(.custom),
                    child: Text(
                      context.l10n.testModeCustom,
                      style: context.textTheme.sfProW500s16.copyWith(
                        color: mode == .custom ? context.color.white : context.color.primary,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 36,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      elevation: 0,
                      padding: Dimension.pH12V8,
                      backgroundColor: mode == .university ? context.color.primary : context.color.white,
                    ),
                    onPressed: () => _onModePressed(.university),
                    child: Text(
                      context.l10n.testModeUniversity,
                      style: context.textTheme.sfProW500s16.copyWith(
                        color: mode == .university ? context.color.white : context.color.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Dimension.hBox16,
            ValueListenableBuilder<CustomTestSettings>(
              valueListenable: settingsNotifier,
              builder: (context, settings, _) {
                settings.testMode = mode;
                return switch (mode) {
                  .custom => CustomModeContent(settings: settings),
                  .university => UniversityModeContent(settings: settings),
                };
              },
            ),
          ],
        ),
      ),
    ],
  );
}
