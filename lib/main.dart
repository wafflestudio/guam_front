import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'providers/user_auth/authenticate.dart';
import 'screens/user_auth/auth.dart';
import 'providers/stacks/stacks.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'dart:math';

/// Create a [AndroidNotificationChannel] for heads up notifications
AndroidNotificationChannel channel;

/// Initialize the [FlutterLocalNotificationsPlugin] package.
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

InitializationSettings initializationSettings;
AndroidInitializationSettings initializationSettingsAndroid;
IOSInitializationSettings initializationSettingsIOS;

/// permission must be requested from your users
/// in order to display remote notifications from FCM
NotificationSettings settings;

/// Create an Android Notification Channel.
Future<void> createAndroidNotificationChannel({AndroidNotificationChannel channel}) async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

/// Update the iOS foreground notification presentation options to allow
/// heads up notifications.
Future<void> allowIOSForegroundNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );
}

void main() async {
  // Returns an instance of the WidgetsBinding, creating and initializing it if necessary.
  // WidgetsBinding provides interaction w/ Flutter Engine.
  WidgetsFlutterBinding.ensureInitialized();

  // Use platform channels to call native code to initialize Firebase.
  // Thus, 'async' main() and placed next to ensureInitialized()
  await Firebase.initializeApp();

  channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    'This channel is used for important notifications.', // description
    importance: Importance.high, // Android foreground messaging requires high importance
  );
  flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  // We use this channel in the `AndroidManifest.xml` file to override the
  // default FCM channel to enable heads up notifications.
  await createAndroidNotificationChannel(channel: channel);
  await allowIOSForegroundNotifications();

  initializationSettingsAndroid = AndroidInitializationSettings('push_icon');
  // initializationSettingsIOS = IOSInitializationSettings(
  //     onDidReceiveLocalNotification: onDidReceiveLocalNotification
  // ); // iOS 푸시 넣기 전 주석처리
  initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    // iOS: initializationSettingsIOS // iOS 푸시 넣기 전 주석처리
  );
  flutterLocalNotificationsPlugin.initialize(initializationSettings);

  settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    // Devices on iOS 12+ can use provisional authorization.
    // This type of permission system allows for notification permission to be
    // instantly granted without displaying a dialog to your user.
    // The permission allows notifications to be displayed quietly
    // (only visible within the device notification center).
    provisional: false,
    sound: true,
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static HexColor themeColor = HexColor('#6200EE');

  @override
  Widget build(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');

      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;

      if (notification != null) {
        if (android != null) {
          flutterLocalNotificationsPlugin.show(
              Random().nextInt(100), // create random id for required field
              notification.title,
              notification.body,
              NotificationDetails(
                android: AndroidNotificationDetails(
                  channel.id,
                  channel.name,
                  channel.description,
                ),
              ));
        }
      }
    });

    return MultiProvider(
        providers: [
          // First-most providers to be initialized
          ChangeNotifierProvider<Authenticate>(
            create: (_) => Authenticate(),
            lazy: false,
          ),
          ChangeNotifierProvider<Stacks>(
            create: (_) => Stacks(),
            lazy: false,
          ),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Auth(),
          },
          theme: ThemeData(
            primaryColor: themeColor,
          ),
          builder: BotToastInit(),
          navigatorObservers: [BotToastNavigatorObserver()],
        )
    );
  }
}
