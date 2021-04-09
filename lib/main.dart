import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'providers/user_auth/authenticate.dart';
import 'screens/home/root.dart';
import 'screens/user_auth/sign_up.dart';
import 'screens/user_auth/sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<Authenticate>(create: (_) => Authenticate()),
        ],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => Root(),
            '/sign_up': (context) => SignUp(),
            '/sign_in': (context) => SignIn(),
          },
          theme: ThemeData(
            primaryColor: HexColor('#6200EE'),
          ),
        )
    );
  }
}
