import 'package:flutter/material.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:provider/provider.dart';

import '../../../commons/custom_app_bar.dart';
import '../../../models/profile.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../my_profile/my_profile.dart';

class AnotherProfile extends StatelessWidget {
  final int userId;

  AnotherProfile(this.userId);

  @override
  Widget build(BuildContext context) {
    final stacksProvider = context.read<Stacks>();
    final authProvider = context.watch<Authenticate>();

    Future<Profile> getUserProfile(int userId) async {
      final Profile profile = await authProvider.getUserProfile(userId);

      return profile;
    }

    // print(getUserProfile(userId));

    return Scaffold(
      appBar: CustomAppBar(
        title: "프로필",
        leading: Back(),
      ),
      body: MyProfile(
        stacksProvider: stacksProvider,
        isMyProfile: false,
        userId: userId,
        // user: getUserProfile(userId),
      ),
    );
  }
}
