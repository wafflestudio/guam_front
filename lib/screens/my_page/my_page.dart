import 'package:flutter/material.dart';
import '../user_auth/kakao_login.dart';
import '../../commons/app_bar.dart';
import 'make_profile_page.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';
import 'my_profile.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();

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
      body: authProvider.loading ?
        Center(child: CircularProgressIndicator()) :
        authProvider.userSignedIn() ?
          authProvider.meExists() ? MyProfile() : MakeProfilePage() :
          Container(
            child: Center(
              child: KakaoLogin(),
            ),
          ),
    );
  }
}
