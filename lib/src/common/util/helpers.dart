import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import '../constant/gen/assets.gen.dart';
import 'screen_util.dart';

/// {@template helpers}
/// Helper class for various utility functions.
/// {@endtemplate}
sealed class Helpers {
  /// {@macro helpers}
  const Helpers._();

  static Future<({String path, double scale})?> getPlatformSpecificLogo() async {
    final logo = Assets.images.logoPng;

    if (kIsWeb) {
      return (path: logo.path, scale: 1.0);
    }

    if (Platform.isIOS) {
      return (path: logo.path, scale: 360 / ScreenUtil.size.width);
    } else if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final version = int.tryParse(androidInfo.version.release) ?? 0;

      if (version <= 12) {
        return (path: logo.path, scale: .5);
      } else {
        return (path: logo.path, scale: 0.7);
      }
    }

    return (path: logo.path, scale: 1.0);
  }
}
