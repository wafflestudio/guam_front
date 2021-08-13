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
    final authProvider = context.read<Authenticate>();

    print("23: ${authProvider.me.nickname}");

    return FutureBuilder(
      future: authProvider.getUserProfile(userId),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: [
              Stack(
                children: [
                  MyProfileLink(snapshot.data),
                  MyProfileTop(snapshot.data),
                ]
              ),
              MyProfileBottom(snapshot.data, stacksProvider),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
