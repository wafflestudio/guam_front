import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import '../user_auth/kakao_login.dart';
import '../../commons/custom_app_bar.dart';
import 'make_profile_page.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';
import 'my_profile.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();
    final stacksProvider = context.read<Stacks>();

    return Scaffold(
      appBar: CustomAppBar(
        title: "프로필",
        trailing: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ),
      ),
      body: authProvider.loading
          ? Center(child: CircularProgressIndicator())
          : authProvider.userSignedIn()
              ? authProvider.profileExists()
                  ? MyProfile()
                  : MakeProfilePage(stacksProvider)
              : Container(
                  child: Center(
                    child: KakaoLogin(),
                  ),
                ),
    );
  }
}
