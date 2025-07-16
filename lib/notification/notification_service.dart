import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  static final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void initializeNotifications() async {
    // Step 1: Android settings
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const InitializationSettings initSettings = InitializationSettings(
      android: androidSettings,
    );
    // Step 2: Initialize the plugin
    await flutterLocalNotificationsPlugin.initialize(initSettings);

    // Step 3: Create notification channel (required for Android 8.0+)
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'quiz_channel',
      'Quiz Notifications',
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  static Future<void> requestNotificationPermission() async {
    final status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      print('Notification permission not granted');
    }
  }
}
