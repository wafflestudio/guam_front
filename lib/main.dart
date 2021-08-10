import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'providers/user_auth/authenticate.dart';
import 'screens/user_auth/auth.dart';
import 'providers/stacks/stacks.dart';
import 'package:bot_toast/bot_toast.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static HexColor themeColor = HexColor('#6200EE');

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          // First-most providers to be initialized
          ChangeNotifierProvider<Authenticate>(create: (_) => Authenticate()),
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
