import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../common/util/error_handler.dart';
import '../data/settings_repository.dart';
import '../models/app_settings.dart';

/// {@template app_settings_bloc}
/// A [Bloc] that handles [AppSettings].
/// {@endtemplate}
final class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  /// {@macro app_settings_bloc}
  SettingsBloc({required ISettingsRepository settingsRepository, required SettingsState initialState})
    : _settingsRepository = settingsRepository,
      super(initialState) {
    on<SettingsEvent>(
      (event, emit) => switch (event) {
        final _UpdateSettingsEvent e => _updateSettings(e, emit),
      },
    );
  }

  final ISettingsRepository _settingsRepository;

  void _updateSettings(_UpdateSettingsEvent event, Emitter<SettingsState> emit) => handle(
    () async {
      emit(_LoadingSettingsState(settings: state.settings));

      await _settingsRepository.setSettings(event.settings);

      emit(_IdleSettingsState(settings: event.settings));
    },
    onError: (error, stacktrace) {
      emit(_ErrorSettingsState(settings: event.settings, error: error));
    },
  );
}

/// States for the [SettingsBloc].
sealed class SettingsState {
  const SettingsState({required this.settings});

  /// The app settings are idle.
  const factory SettingsState.idle({required AppSettings settings}) = _IdleSettingsState;

  /// The app settings are loading.
  const factory SettingsState.loading({required AppSettings settings}) = _LoadingSettingsState;

  /// The app settings have an error.
  const factory SettingsState.error({required Object error, required AppSettings settings}) = _ErrorSettingsState;

  /// Application locale.
  final AppSettings settings;
}

@immutable
final class _IdleSettingsState extends SettingsState {
  const _IdleSettingsState({required super.settings});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _IdleSettingsState && other.settings == settings;
  }

  @override
  int get hashCode => settings.hashCode;

  @override
  String toString() => 'SettingsState.idle(settings: $settings)';
}

@immutable
final class _LoadingSettingsState extends SettingsState {
  const _LoadingSettingsState({required super.settings});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _LoadingSettingsState && other.settings == settings;
  }

  @override
  int get hashCode => settings.hashCode;

  @override
  String toString() => 'SettingsState.loading(settings: $settings)';
}

@immutable
final class _ErrorSettingsState extends SettingsState {
  const _ErrorSettingsState({required this.error, required super.settings});

  /// The error.
  final Object error;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _ErrorSettingsState && other.settings == settings && other.error == error;
  }

  @override
  int get hashCode => Object.hash(settings, error);

  @override
  String toString() => 'SettingsState.error(settings: $settings, error: $error)';
}

/// Events for the [AppSettingsBloc].
sealed class SettingsEvent {
  const SettingsEvent();

  /// Update the app settings.
  const factory SettingsEvent.updateSettings({required AppSettings settings}) = _UpdateSettingsEvent;
}

final class _UpdateSettingsEvent extends SettingsEvent {
  const _UpdateSettingsEvent({required this.settings});

  /// The theme to update.
  final AppSettings settings;

  @override
  String toString() => 'SettingsEvent.updateSettings(settings: $settings)';
}
