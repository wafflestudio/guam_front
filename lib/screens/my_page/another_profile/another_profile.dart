import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_bottom.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_link.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_top.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_auth/authenticate.dart';

class AnotherProfile extends StatelessWidget {
  final Stacks stacksProvider;
  final int userId;

  AnotherProfile({
    this.stacksProvider,
    this.userId,
  });

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();

    Future.delayed(Duration.zero, () {
      authProvider.getUserProfile(userId);
    });
    final profile = authProvider.user;
    // final profile = isMyProfile ? authProvider.me : user;

    return SingleChildScrollView(
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
              Stack(
                  children: [
                    MyProfileLink(profile),
                    MyProfileTop(profile),
                  ]
              ),
              MyProfileBottom(profile, stacksProvider),
            ],
          ),
        )
    );
  }
}
