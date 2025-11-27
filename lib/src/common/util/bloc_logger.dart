import 'package:flutter_bloc/flutter_bloc.dart';

import '../extension/string_extension.dart';
import 'logger.dart';

/// {@template bloc_logger}
/// Logger for [Bloc]s.
/// {@endtemplate}
final class BlocLogger extends BlocObserver {
  /// {@macro bloc_logger}
  const BlocLogger();

  /// {@macro bloc_logger}
  /// Called whenever a [Bloc] transitions from one state to another.
  /// [super.onTransition] is invoked at the end of this method.
  ///
  /// Listens to all [Bloc]s and logs the transition from [Transition.currentState]
  /// to [Transition.nextState] along with the event which triggered the transition.
  ///
  /// The log message includes the following information:
  ///
  /// - The type of the [Bloc]
  /// - The type of the event
  /// - The change in status (e.g. `initial => success`)
  /// - The new state (truncated to 150 characters)
  @override
  void onTransition(Bloc<Object?, Object?> bloc, Transition<Object?, Object?> transition) {
    final nextStateString = transition.nextState?.toString() ?? '';
    final nextStatusMatch = RegExp(r'status\.([\w]+)').firstMatch(nextStateString.toLowerCase());
    final nextStatus = nextStatusMatch?.group(1) ?? 'unknown';

    final currentStateString = transition.currentState?.toString() ?? '';
    final currentStatusMatch = RegExp(r'status\.([\w]+)').firstMatch(currentStateString.toLowerCase());
    final currentStatus = currentStatusMatch?.group(1) ?? 'unknown';

    final logMessage = StringBuffer()
      ..writeln('\nBloc: ${bloc.runtimeType}')
      ..writeln('Event: ${transition.event.runtimeType}')
      ..writeln('Status: $currentStatus => $nextStatus')
      ..write('New State: ${transition.nextState?.toString().ellipsis(150)}');

    info(logMessage);
    super.onTransition(bloc, transition);
  }

  /// Called whenever a [Bloc] processes an [event].
  ///
  /// Listens to all [Bloc]s and logs the [event] which was processed.
  ///
  /// The log message includes the following information:
  ///
  /// - The type of the [Bloc]
  /// - The type of the event
  /// - The details of the event (truncated to 150 characters)
  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    final logMessage = StringBuffer()
      ..writeln('\nBloc: ${bloc.runtimeType}')
      ..writeln('Event: ${event.runtimeType}')
      ..write('Details: ${event?.toString().ellipsis(150)}');

    info(logMessage.toString());
    super.onEvent(bloc, event);
  }

  /// Called whenever a [Bloc] or [Cubit] encounters an error.
  ///
  /// Listens to all [Bloc]s and logs the error details, including the stack trace.
  ///
  /// The log message includes the following information:
  ///
  /// - The type of the [Bloc]
  /// - The error message
  ///
  /// The error is logged using the [severe] level.
  @override
  void onError(BlocBase<Object?> bloc, Object error, StackTrace stackTrace) {
    final logMessage = StringBuffer()
      ..writeln('\nBloc: ${bloc.runtimeType}')
      ..writeln(error.toString());

    severe(logMessage.toString(), stackTrace);
    super.onError(bloc, error, stackTrace);
  }

  /// Called whenever a [Bloc] or [Cubit] is created.
  ///
  /// Listens to all [Bloc]s and logs the initial state of the [Bloc].
  ///
  /// The log message includes the following information:
  ///
  /// - The type of the [Bloc]
  /// - The initial state of the [Bloc] (truncated to 150 characters)
  ///
  /// The log message is logged using the [info] level.
  @override
  void onCreate(BlocBase<Object?> bloc) {
    final logMessage = StringBuffer()
      ..writeln('\n┌─ Bloc Created: ${bloc.runtimeType}')
      ..write('└─ Initial State: ${bloc.state.toString().ellipsis(150)}');

    warning(logMessage.toString());
    super.onCreate(bloc);
  }

  /// Called whenever a [Bloc] is closed.
  ///
  /// Listens to all [Bloc]s and logs the final state of the [Bloc].
  ///
  /// The log message includes the following information:
  ///
  /// - The type of the [Bloc]
  /// - The final state of the [Bloc] (truncated to 150 characters)
  ///
  /// The log message is logged using the [info] level.
  @override
  void onClose(BlocBase<Object?> bloc) {
    final logMessage = StringBuffer()
      ..writeln('\n┌─ Bloc Closed: ${bloc.runtimeType}')
      ..write('└─ Final State: ${bloc.state.toString().ellipsis(150)}');

    info(logMessage.toString());
    super.onClose(bloc);
  }
}
