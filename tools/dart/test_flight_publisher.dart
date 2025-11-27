import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

final class AppConstants {
  const AppConstants._();

  static const int maxRetries = 2;
  static const Duration baseDelay = Duration(minutes: 5);
  static const Duration loadingAnimationInterval = Duration(milliseconds: 100);
  static const List<String> loadingSymbols = ['⣾', '⣷', '⣯', '⣟', '⡿', '⢿', '⣻', '⣽'];

  static const String apiEndpoint = 'https://automate-testflight.onrender.com/testflight/publish';
  static const Map<String, Object?> defaultPayload = {
    'app_id': '',
    'beta_group_id': '',
    'whats_new': 'string',
    'telegram_group_id': -1002209676222,
    'test_flight_url': '',
  };
}

final class Logger {
  const Logger._();

  static void info(String message) => stdout.writeln('\x1B[38;2;70;198;178m[INFO]\x1B[0m $message');
  static void error(String message) => stdout.writeln('\x1B[38;2;239;68;68m[ERROR]\x1B[0m $message');
  static void debug(String message) => stdout.writeln('\x1B[38;2;150;150;150m[DEBUG]\x1B[0m $message');
}

class LoadingAnimation {
  LoadingAnimation({this.message = 'Waiting'});

  Timer? _timer;
  Timer? _countdownTimer;
  final String message;
  late DateTime _endTime;

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  void start(Duration totalDuration) {
    var tick = 0;
    _endTime = DateTime.now().add(totalDuration);

    _timer = Timer.periodic(AppConstants.loadingAnimationInterval, (timer) {
      final remainingTime = _endTime.difference(DateTime.now());
      if (remainingTime.isNegative) {
        stop();
        return;
      }

      final timeLeft = _formatDuration(remainingTime);
      stdout.write('\r${AppConstants.loadingSymbols[tick % AppConstants.loadingSymbols.length]} $message ($timeLeft)');
      tick++;
    });
  }

  void stop() {
    _timer?.cancel();
    _countdownTimer?.cancel();
    stdout.write('\r');
  }
}

final class ApiClient {
  ApiClient() : _dio = Dio();

  final Dio _dio;

  Future<Map<String, Object?>> publishToTestFlight() async {
    try {
      Logger.debug('\nSending request to ${AppConstants.apiEndpoint}');

      final response = await _dio.post<Map<String, Object?>>(
        AppConstants.apiEndpoint,
        data: AppConstants.defaultPayload,
      );

      if (response.data == null) {
        throw Exception('Empty response received');
      }

      Logger.info('Successfully published to TestFlight');
      return response.data as Map<String, Object?>;
    } on DioException catch (e) {
      Logger.error('HTTP Error ${e.response?.statusCode}: ${e.response?.data}');
      rethrow;
    } on Object catch (e) {
      Logger.error('Unexpected error: $e');
      rethrow;
    }
  }
}

String _formatElapsedTime(Duration duration) {
  final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
  final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
  return '$minutes:$seconds';
}

Future<void> main() async {
  final sw = Stopwatch()..start();

  var retryCount = 0;
  final apiClient = ApiClient();
  final loadingAnimation = LoadingAnimation();

  Future<void> attemptPublish() async {
    final duration = AppConstants.baseDelay * (retryCount + 1);
    Logger.info('Attempting publish (try ${retryCount + 1}/${AppConstants.maxRetries})');
    Logger.debug('Waiting for $duration before attempt');

    loadingAnimation.start(duration);

    try {
      await Future<void>.delayed(duration);
      final response = await apiClient.publishToTestFlight();
      loadingAnimation.stop();
      Logger.info('Response: $response');
      sw.stop();
      Logger.info('Total time: ${_formatElapsedTime(sw.elapsed)}');
    } on Object catch (_) {
      loadingAnimation.stop();

      if (retryCount < AppConstants.maxRetries - 1) {
        retryCount++;
        Logger.info('Retrying...');
        await attemptPublish();
      } else {
        Logger.error('Max retries reached. Exiting.');
        sw.stop();
        Logger.info('Total time: ${_formatElapsedTime(sw.elapsed)}');
        exit(1);
      }
    }
  }

  await attemptPublish();
}
