import 'dart:io';
import 'dart:ui';

import 'package:elixir/elixir.dart';
import 'package:flutter/material.dart';
import 'package:local_source/local_source.dart';

import '../../feature/settings/bloc/settings_bloc.dart';
import '../../feature/settings/screen/settings_scope.dart';
import '../dependencies/model/app_metadata.dart';
import '../dependencies/model/dependencies.dart';
import '../dependencies/widget/dependencies_scope.dart';
import '../localization/localization.dart';
import '../theme/theme_colors.dart';
import '../theme/theme_text_style.dart';
import '../util/logger.dart';
import '../widget/custom_notification.dart';

/// [BuildContextX]
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  ColorScheme get colorScheme => theme.colorScheme;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  ThemeColors get color => theme.extension<ThemeColors>()!;

  ThemeTextStyles get textTheme => theme.extension<ThemeTextStyles>()!;

  Localization get l10n => Localization.of(this);

  Dependencies get dependencies => DependenciesScope.of(this);
  RepositoryContainer get repository => dependencies.repository;
  BlocContainer get bloc => dependencies.bloc;
  DioContainer get dios => dependencies.dio;
  LocalSource get localSource => dependencies.localeSource;
  AppMetadata get appMetadata => dependencies.metadata;

  void setLocale(Locale localization) => SettingsScope.of(
    this,
  ).add(SettingsEvent.updateSettings(settings: SettingsScope.settingsOf(this).copyWith(localization: localization)));

  void setThemeMode(ThemeMode themeMode) => SettingsScope.of(
    this,
  ).add(SettingsEvent.updateSettings(settings: SettingsScope.settingsOf(this).copyWith(themeMode: themeMode)));
}

/// [SizeX]
extension SizeX on BuildContext {
  Size get pageSize => MediaQuery.sizeOf(this);

  bool get isMobile => kSize.width < 600 && (Platform.isAndroid || Platform.isIOS);

  bool get isTablet => kSize.width > 600 && (Platform.isAndroid || Platform.isIOS);

  Size get kSize => MediaQuery.sizeOf(this);

  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;
}

/// [NavigatorX]
extension NavigatorX on BuildContext {
  bool get canPop => Navigator.canPop(this);

  void pop() => elixir.pop();

  void push(ElixirPage page) {
    elixir.change((state) {
      if (state.isNotEmpty && state.last.name == page.name) {
        warning('[NavigatorX] push canceled: trying to push same page "${page.name}"');
        return state;
      }
      final newState = List<ElixirPage>.from(state)..add(page);
      return newState;
    });
  }

  void pushReplacement(ElixirPage page) {
    elixir.change((state) {
      if (state.isNotEmpty && state.last.name == page.name) return state;

      final newState = List<ElixirPage>.from(state);

      if (newState.isNotEmpty) newState.clear();
      newState.add(page);
      return newState;
    });
  }
}

/// [CustomDialogX]
extension CustomDialogX on BuildContext {
  Future<void> showCustomDialog({required Widget dialog, bool barrierDismissible = true}) => showGeneralDialog(
    context: this,
    pageBuilder: (context, _, __) => dialog,
    barrierLabel: '',
    barrierColor: Colors.black26,
    barrierDismissible: barrierDismissible,
    transitionBuilder: (ctx, anim1, anim2, child) => BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10 * anim1.value, sigmaY: 10 * anim1.value),
      child: FadeTransition(opacity: anim1, child: child),
    ),
  );

  void showLoading() => showDialog<void>(
    context: this,
    barrierColor: Colors.black26,
    barrierDismissible: false,
    builder: (context) => PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) => false,
      child: Center(
        child: RepaintBoundary(
          child: CircularProgressIndicator(
            backgroundColor: Colors.black12,
            color: context.color.success,
            strokeCap: StrokeCap.round,
          ),
        ),
      ),
    ),
  );

  void hideLoading() {
    if (Navigator.of(this, rootNavigator: true).canPop()) {
      Navigator.of(this, rootNavigator: true).pop();
    }
  }
}

/// [CustomNotificationX]
extension CustomNotificationX on BuildContext {
  void showNotification({
    required String message,
    Color? backgroundColor,
    Color? textColor,
    TextStyle? textStyle,
    Widget? icon,
    BorderRadius? radius,
    CustomNotification? position,
    Duration? duration,
    bool testMode = false,
  }) => CustomNotification.show(
    context: this,
    message: message,
    backgroundColor: backgroundColor,
    textStyle: textStyle,
    duration: duration,
    icon: icon,
    radius: radius,
    testMode: testMode,
  );

  /// Hide the current custom notification.
  void hideNotification() => CustomNotification.hideCurrentNotification();
}

/// List of extensions for [BuildContext]
extension ContextExtension on BuildContext {
  /// Obtain the nearest widget of the given type T,
  /// which must be the type of a concrete [InheritedWidget] subclass,
  /// and register this build context with that widget such that
  /// when that widget changes (or a new widget of that type is introduced,
  /// or the widget goes away), this build context is rebuilt so that it can
  /// obtain new values from that widget.
  T? inhMaybeOf<T extends InheritedWidget>({bool listen = true}) =>
      listen ? dependOnInheritedWidgetOfExactType<T>() : getInheritedWidgetOfExactType<T>();

  /// Obtain the nearest widget of the given type T,
  /// which must be the type of a concrete [InheritedWidget] subclass,
  /// and register this build context with that widget such that
  /// when that widget changes (or a new widget of that type is introduced,
  /// or the widget goes away), this build context is rebuilt so that it can
  /// obtain new values from that widget.
  T inhOf<T extends InheritedWidget>({bool listen = true}) =>
      inhMaybeOf<T>(listen: listen) ??
      (throw ArgumentError(
        'Out of scope, not found inherited widget '
            'a $T of the exact type',
        'out_of_scope',
      ));

  /// Maybe inherit specific aspect from [InheritedModel].
  T? maybeInheritFrom<A extends Object, T extends InheritedModel<A>>({A? aspect}) =>
      InheritedModel.inheritFrom<T>(this, aspect: aspect);

  /// Inherit specific aspect from [InheritedModel].
  T inheritFrom<A extends Object, T extends InheritedModel<A>>({A? aspect}) =>
      maybeInheritFrom(aspect: aspect) ??
      (throw ArgumentError(
        'Out of scope, not found inherited model '
            'a $T of the exact type',
        'out_of_scope',
      ));
}
