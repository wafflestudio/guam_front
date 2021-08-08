import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_bottom.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_link.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_top.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_auth/authenticate.dart';
import '../../user_auth/sign_out.dart';

class MyProfile extends StatelessWidget {
  final Stacks stacksProvider;
  final bool isMyProfile;

  MyProfile({this.stacksProvider, this.isMyProfile});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();
    final profile = isMyProfile ? authProvider.me : authProvider.me;

    return SingleChildScrollView(
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7), BlendMode.dstATop),
              image: AssetImage("assets/backgrounds/profile-bg-1.png"),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                Stack(children: [
                  MyProfileLink(profile),
                  MyProfileTop(profile),
                ]),
                MyProfileBottom(profile, stacksProvider),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 30),
            child: Center(
              child: SignOut(),
            ),
          )
        ],
      ),
    );
  }
}
