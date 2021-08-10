import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_bottom.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_link.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_top.dart';
import 'package:provider/provider.dart';

import '../../../models/profile.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../../user_auth/sign_out.dart';

class MyProfile extends StatelessWidget {
  final Stacks stacksProvider;
  final bool isMyProfile;
  final int userId;
  final Profile user;

  MyProfile({
    this.stacksProvider,
    this.isMyProfile,
    this.userId,
    this.user,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();

    Future.delayed(Duration.zero, () {
      if(!isMyProfile) {
        authProvider.getUserProfile(userId);
      }
    });
    final profile = isMyProfile ? authProvider.me : authProvider.user;
    // final profile = isMyProfile ? authProvider.me : user;

    return SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 30),
            child: DecoratedBox(
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
          ),
          if (isMyProfile) Center(child: SignOut()),
        ],
      ),
    );
  }
}
