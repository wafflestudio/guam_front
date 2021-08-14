import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../providers/home/home_provider.dart';
import '../home/home.dart';

class Messaging extends StatelessWidget {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final AndroidNotificationChannel maxImportanceChannel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max, // for allowing foreground messaging
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  Future allowIOSForegroundNotifications() async {
    await messaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  Future createAndroidNotificationChannel() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(maxImportanceChannel);
  }

  @override
  Widget build(BuildContext context) {
    requestPermission();
    allowIOSForegroundNotifications();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null) {
        print('Message also contained a notification: $notification');

        if (android != null) {
          flutterLocalNotificationsPlugin.show(
              notification.hashCode,
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  maxImportanceChannel.id,
                  maxImportanceChannel.name,
                  maxImportanceChannel.description,
                  icon: android?.smallIcon,
                  // other properties...
                ),
              ));
        }
      }
    });

    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Home(),
    );
  }
}
