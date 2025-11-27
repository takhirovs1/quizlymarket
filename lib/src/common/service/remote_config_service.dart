import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';

import '../extension/context_extension.dart';

@immutable
sealed class RemoteConfigService {
  const RemoteConfigService._();

  static FirebaseRemoteConfig remoteConfig = FirebaseRemoteConfig.instance;

  static Future<(AppUpdate, String, String)> isCallCheckAppVersion(BuildContext context) async {
    try {
      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(fetchTimeout: Duration.zero, minimumFetchInterval: Duration.zero),
      );

      await remoteConfig.fetchAndActivate();

      RemoteConfigValue? version;

      if (Platform.isAndroid) {
        version = remoteConfig.getAll()['android'];
      } else {
        version = remoteConfig.getAll()[TargetPlatform.iOS.name];
      }

      if (!context.mounted) return (AppUpdate.none, '', '');

      final isNotLast = isNotLastVersion(context.dependencies.metadata.appVersion, version);

      return isNotLast;
    } on Object catch (e, s) {
      log('Firebase initialize error: $e $s');
      return (AppUpdate.none, '', '');
    }
  }

  static (AppUpdate, String, String) isNotLastVersion(String appVersion, RemoteConfigValue? employeeVersion) {
    if (employeeVersion == null) {
      return (AppUpdate.none, '', '');
    }

    final appVersionApp = const JsonDecoder().cast<String, Map<String, Object?>>().convert(employeeVersion.asString());
    final version = (appVersionApp['version'] as String?) ?? '';
    final isForce = (appVersionApp['is_force'] as bool?) ?? false;
    final employee = version.replaceAll('.', '').toVersion;
    final package = appVersion.replaceAll('.', '').toVersion;

    if (package < employee && isForce) {
      return (AppUpdate.forceUpdate, appVersion, version);
    }

    if (package < employee && !isForce) {
      return (AppUpdate.softUpdate, appVersion, version);
    }

    return (AppUpdate.none, '', '');
  }
}

enum AppUpdate { forceUpdate, softUpdate, none }

extension VersionParsing on String {
  int get toVersion => int.tryParse(replaceAll('.', '')) ?? 0;
}
