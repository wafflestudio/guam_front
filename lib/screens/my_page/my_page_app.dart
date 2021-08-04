import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:provider/provider.dart';

import '../../commons/custom_app_bar.dart';
import '../../providers/user_auth/authenticate.dart';
import '../user_auth/kakao_login.dart';
import 'make_profile_page.dart';
import 'my_profile/my_profile.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();
    final stacksProvider = context.read<Stacks>();

    return Scaffold(
      appBar: CustomAppBar(
        title: "프로필",
        trailing: authProvider.profileExists()
            ? TextButton(
                child: Text(
                  'Edit',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
                onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => MakeProfilePage(stacksProvider: stacksProvider))),
              )
            : null,
      ),
      body: authProvider.loading
          ? Center(child: CircularProgressIndicator())
          : authProvider.userSignedIn()
              ? authProvider.profileExists()
                  ? MyProfile(stacksProvider)
                  : MakeProfilePage(stacksProvider: stacksProvider, showAppBar: false)
              : Container(
                  child: Center(
                    child: KakaoLogin(),
                  ),
                ),
    );
  }
}
