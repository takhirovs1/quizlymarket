import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

import '../constant/gen/assets.gen.dart';
import 'screen_util.dart';

/// {@template helpers}
/// Helper class for various utility functions.
/// {@endtemplate}
sealed class Helpers {
  /// {@macro helpers}
  const Helpers._();

  static Future<({String path, double scale})?> getPlatformSpecificLogo() async {
    if (Platform.isIOS) {
      return (path: Assets.images.placeholder.path, scale: 360 / ScreenUtil.size.width);
      // return (path: Assets.vectors.tvrIcon1440.path, scale: 360 / ScreenUtil.size.width);
    } else if (Platform.isAndroid) {
      final deviceInfo = DeviceInfoPlugin();
      final androidInfo = await deviceInfo.androidInfo;
      final version = int.tryParse(androidInfo.version.release) ?? 0;

      if (version <= 12) {
        return (path: Assets.images.placeholder.path, scale: .5);
        // return (path: Assets.vectors.tvrIcon1080.path, scale: .5);
      } else {
        return (path: Assets.images.placeholder.path, scale: 0.7);
        // return (path: Assets.vectors.tvrIcon1440.path, scale: 0.7);
      }
    }

    return null;
  }
}
