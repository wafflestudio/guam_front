import 'package:flutter/material.dart';
import '../user_auth/kakao_login.dart';
import '../../commons/app_bar.dart';
import 'make_profile_page.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();
    // print(authProvider.meExists());

    return Scaffold(
      appBar: appBar(
        title: "프로필",
        trailing: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ),
      ),
      body: authProvider.userSignedIn() ?
        authProvider.meExists() ? Container() : MakeProfilePage() :
        Container(
          child: Center(
            child: authProvider.loading ?
              CircularProgressIndicator() :
              Column(
                children: [
                  KakaoLogin(),
                ],
              )
          )
        )
    );
  }
}
