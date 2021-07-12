import 'package:flutter/material.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_link.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_auth/authenticate.dart';
import '../../user_auth/sign_out.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();

    return DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
          colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7), BlendMode.dstATop),
          image: AssetImage("assets/backgrounds/profile-bg-1.png"),
          fit: BoxFit.cover,
        )),
        child: Center(
          child: Column(
            children: [
              MyProfileLink(authProvider.me),
              Text(authProvider.me.nickname ?? ""),
              Text(authProvider.me.githubUrl ?? ""),
              Text(authProvider.me.blogUrl ?? ""),
              Text(authProvider.me.skills == []
                  ? ""
                  : authProvider.me.skills.toString()),
              Text(authProvider.me.introduction ?? ""),
              Center(
                child: SignOut(),
              )
            ],
          ),
        ));
  }
}
