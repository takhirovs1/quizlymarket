import 'dart:async' show FutureOr;

import 'package:dio/dio.dart';

import '../extension/string_extension.dart';
import 'logger.dart' show severe;

/// Handles asynchronous operations with structured error handling and reporting.
///
/// Parameters:
/// - [handler]: The main async operation to execute
/// - [onDioError]: Optional callback for handling Dio-specific network errors
/// - [onError]: Optional callback for handling general errors
/// - [onFinally]: Optional callback that runs after completion (success or failure)
/// - [shouldLog]: Whether to log errors (defaults to true)
/// - [name]: Optional identifier for logging purposes
///
/// Example usage:
/// ```dart
/// await handle(
///   () async {
///     // Main operation
///     final response = await repository.fetchData();
///     emit(state.copyWith(data: response));
///   },
///   name: 'FetchUserData',
///   onDioError: (error, stackTrace) async {
///     // Handle network errors
///     emit(state.copyWith(
///       status: Status.error,
///       error: error.message,
///     ));
///   },
///   onError: (error, stackTrace) async {
///     // Handle other errors
///     emit(state.copyWith(
///       status: Status.error,
///       error: error.toString(),
///     ));
///   },
///   onFinally: () async {
///     // Cleanup or final operations
///     emit(state.copyWith(isLoading: false));
///   },
/// );
/// ```
///
/// Error Handling Flow:
/// 1. Executes [handler]
/// 2. If DioException occurs, calls [onDioError]
/// 3. If other error occurs, calls [onError]
/// 4. Always executes [onFinally] if provided
/// 5. Logs errors if [shouldLog] is true
Future<void> handle(
  FutureOr<void> Function() handler, {
  FutureOr<void> Function(DioException e, StackTrace s)? onDioError,
  FutureOr<void> Function(Object e, StackTrace s)? onError,
  FutureOr<void> Function()? onFinally,
  bool shouldLog = true,
  String name = '',
}) async {
  try {
    await handler();
  } on DioException catch (error, stacktrace) {
    if (shouldLog) {
      final logMessage = StringBuffer()
        ..writeln('\n${name.isNotEmpty ? '| $name |' : ''}DIO EXCEPTION OCCURRED')
        ..writeln(
          'Path: ${error.requestOptions.path} ┃ Method: ${error.requestOptions.method} ┃ Status Code: ${error.response?.statusCode}',
        )
        ..writeln('Message: ${(error.message ?? '').ellipsis(150)}')
        ..writeln('Body: ${error.requestOptions.data}');

      severe(logMessage.toString(), stacktrace);
    }

    await onDioError?.call(error, stacktrace);
  } on Object catch (error, stacktrace) {
    if (shouldLog) severe('${name.isNotEmpty ? '| $name |' : ''} Object exception occurred: $error', stacktrace);

    await onError?.call(error, stacktrace);
  } finally {
    await onFinally?.call();
  }
}
