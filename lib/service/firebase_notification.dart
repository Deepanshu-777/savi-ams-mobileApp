import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../theme/app_colors.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("Title: ${message.notification?.title}");
  log("Body: ${message.notification?.body}");
  log("Payload: ${message.data}");
}

class FirebaseNotification {
  final firebaseMessaging = FirebaseMessaging.instance;

  final androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications',
    importance: Importance.max,
  );

  final localNotifications = FlutterLocalNotificationsPlugin();

  void handleMessage(RemoteMessage? message) {
    log(message?.notification?.body ?? "NULL");
    // log(message?.data.toString() ?? "NULL");
    // if (message == null)
    //   return;
    // else {
    //   Get.toNamed(message.data["route"]);
    // }
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('@drawable/ic_notification');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await localNotifications.initialize(
      settings,
      onDidReceiveNotificationResponse: (notificationResponse) {
        final message = RemoteMessage.fromMap(
          jsonDecode(notificationResponse.payload!),
        );
        handleMessage(message);
      },
    );

    final platform = localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }

  Future initPushNotification() async {
    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    firebaseMessaging.getInitialMessage().then(
          (RemoteMessage? message) => handleMessage(message),
        );

    FirebaseMessaging.onMessageOpenedApp.listen((notification) {
      handleMessage(notification);
    });

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);

    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) return;

      localNotifications.show(
        notification.hashCode,
        notification.title,
        notification.body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidChannel.id,
            androidChannel.name,
            channelDescription: androidChannel.description,
            icon: '@drawable/ic_notification',
            color: AppColors.white,
            colorized: true,
            styleInformation: BigTextStyleInformation(notification.body ?? ""),
          ),
        ),
        payload: jsonEncode(message.toMap()),
      );
    });
  }

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    log("FCM token : $fcmToken");

    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    await initPushNotification();
    await initLocalNotifications();
  }

}
