import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/profiles/profile_bottom.dart';
import 'package:guam_front/screens/profiles/profile_link.dart';
import 'package:guam_front/screens/profiles/profile_top.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_auth/authenticate.dart';
import '../../user_auth/sign_out.dart';
import 'button_report.dart';

class MyProfile extends StatelessWidget {
  final Stacks stacksProvider;

  MyProfile({this.stacksProvider});

  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();
    final profile = authProvider.me;

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
                if (profile.blogUrl != '' || profile.githubUrl != '')
                  ProfileLink(profile),
                ProfileTop(profile),
              ]
            ),
            ProfileBottom(profile, stacksProvider),
            Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  ButtonReport(),
                  SignOut()
                ],
              )
            )
          ],
        ),
      )
    );
  }
}
