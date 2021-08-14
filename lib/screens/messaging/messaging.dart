import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import '../../providers/home/home_provider.dart';
import '../home/home.dart';
import 'dart:math';

class Messaging extends StatelessWidget {
  final FirebaseMessaging messaging = FirebaseMessaging.instance;
  final AndroidNotificationChannel maxImportanceChannel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.max, // for allowing foreground messaging
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
  AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('app_icon');
  // IOSInitializationSettings initializationSettingsIOS = IOSInitializationSettings(
  //     onDidReceiveLocalNotification: onDidReceiveLocalNotification)
  // ;

  InitializationSettings initializationSettings = InitializationSettings(
      android: AndroidInitializationSettings('app_icon'),
      // iOS: initializationSettingsIOS
  );

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

  Future getFirebaseMessagingToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    print("fcm token: $token");

    return token;
  }

  @override
  Widget build(BuildContext context) {
    requestPermission();
    allowIOSForegroundNotifications();

    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null) {
        print('Message also contained a notification: $notification');

        if (android != null) {
          print("Max channel id: ${maxImportanceChannel.id}");
          print("Max channel id: ${maxImportanceChannel.name}");
          print("Max channel id: ${maxImportanceChannel.description}");

          flutterLocalNotificationsPlugin.show(
              // notification.hashCode,
              Random().nextInt(100), //temp 100
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  maxImportanceChannel.id,
                  maxImportanceChannel.name,
                  maxImportanceChannel.description,
                  icon: null, //
                  // other properties...
                ),
              ));
        }
      }
    });

    getFirebaseMessagingToken();

    return ChangeNotifierProvider(
      create: (_) => HomeProvider(),
      child: Home(),
    );
  }
}
