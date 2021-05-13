import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'providers/user_auth/authenticate.dart';
import 'screens/home/root.dart';
import 'screens/user_auth/sign_up.dart';
import 'screens/user_auth/sign_in.dart';

void main() {
  KakaoContext.clientId = "367d8cf339e2ba59376ba647c7135dd2";
  KakaoContext.javascriptClientId = "2edf60d1ebf23061d200cfe4a68a235a";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static HexColor themeColor = HexColor('#6200EE');

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
            primaryColor: themeColor,
          ),
        )
    );
  }
}
