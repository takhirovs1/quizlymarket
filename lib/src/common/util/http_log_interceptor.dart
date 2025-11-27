import 'package:dio/dio.dart';
import 'package:meta/meta.dart';

import 'logger.dart';

/// {@template http_log_interceptor}
/// HttpLogInterceptor class
/// {@endtemplate}
class HttpLogInterceptor extends Interceptor {
  /// {@macro http_log_interceptor}
  @literal
  const HttpLogInterceptor({this.requests = false, this.responses = true, this.errors = true});

  static const String _stopwatchKey = '@stopwatch';

  final bool requests;
  final bool responses;
  final bool errors;

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (requests) fine('${options.method} > ${options.uri}');
    final stopwatch = Stopwatch()..start();
    handler.next(options.copyWith(extra: <String, Object?>{...options.extra, _stopwatchKey: stopwatch}));
  }

  @override
  void onResponse(Response<Object?> response, ResponseInterceptorHandler handler) {
    if (responses) {
      fine(
        '${response.requestOptions.method} > '
        '${response.requestOptions.uri} > '
        '${response.statusCode}: ${response.statusMessage} | '
        '${_extractElapsedTime(response.requestOptions)}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final status = switch (err.response) {
      final Response<Object?> response => '${response.statusCode}: ${response.statusMessage}',
      _ => err.message ?? err.error?.toString() ?? err.type.name,
    };
    if (errors) {
      warning(
        '${err.requestOptions.method} > '
        '${err.requestOptions.uri} > '
        '$status | '
        '${_extractElapsedTime(err.requestOptions)}',
      );
    }
    handler.next(err);
  }

  String _extractElapsedTime(RequestOptions options) {
    if (options.extra[_stopwatchKey] case final Stopwatch sw) {
      return ' ${(sw..stop()).elapsedMilliseconds} ms';
    }
    return '';
  }
}
