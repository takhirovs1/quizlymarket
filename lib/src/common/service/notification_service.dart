import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import '../util/logger.dart';

late AndroidNotificationChannel channel;
late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

InitializationSettings initializationSettings = const InitializationSettings(
  android: AndroidInitializationSettings('@mipmap/ic_launcher'),
  iOS: DarwinInitializationSettings(),
);

/// {@template notification_service}
/// Service for notifications.
/// {@endtemplate}
sealed class NotificationService {
  /// {@macro notification_service}
  const NotificationService._();

  /// Initialize the notification service.
  static Future<void> initialize() async {
    try {
      await FirebaseMessaging.instance.getToken().then((token) => info('FCM TOKEN: $token'));
    } on Object catch (e, s) {
      severe(e, s);
    }
    await setupFlutterNotifications();
    await foregroundNotification();
    backgroundNotification();
    await terminateNotification();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> setupFlutterNotifications() async {
    if (Platform.isIOS) {
      await FirebaseMessaging.instance.requestPermission(criticalAlert: true, announcement: true, provisional: true);
    }
    channel = const AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.high,
    );

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  static void showFlutterNotification(RemoteMessage message) {
    // Get title and body from notification or data payload
    final title = message.notification?.title ?? message.data['title'] as String?;
    final body = message.notification?.body ?? message.data['body'] as String?;

    // Only show if we have something to display
    if ((title != null || body != null) && !kIsWeb) {
      flutterLocalNotificationsPlugin
          .show(
            message.hashCode,
            title,
            body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                channel.id,
                channel.name,
                channelDescription: channel.description,
                styleInformation: BigTextStyleInformation(body ?? '', contentTitle: title),
                icon: '@mipmap/ic_launcher',
                priority: Priority.high,
                importance: Importance.high,
                visibility: NotificationVisibility.public,
              ),
              iOS: const DarwinNotificationDetails(
                presentAlert: true,
                presentBadge: true,
                presentSound: true,
                sound: 'default',
              ),
            ),
            payload: message.data['route'] as String?,
          )
          .ignore();
    }
  }

  static Future<void> foregroundNotification() async {
    FirebaseMessaging.onMessage.listen(showFlutterNotification);

    /// When tapped
    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) {
        info('foreground notification tapped');
        info('$response');
      },
    );
  }

  static void backgroundNotification() => FirebaseMessaging.onMessageOpenedApp.listen(showFlutterNotification);

  static Future<void> terminateNotification() async {
    final remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
    if (remoteMessage == null) {
      FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    } else {
      showFlutterNotification(remoteMessage);
    }
  }
}

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await NotificationService.setupFlutterNotifications();

  NotificationService.showFlutterNotification(message);
}
