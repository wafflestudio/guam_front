import 'package:flutter/material.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:provider/provider.dart';

import '../../../commons/custom_app_bar.dart';
import '../my_profile/my_profile.dart';

class AnotherProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final stacksProvider = context.read<Stacks>();

    return Scaffold(
      appBar: CustomAppBar(
        title: "프로필",
        leading: Back(),
      ),
      body: MyProfile(stacksProvider: stacksProvider, isMyProfile: false),
    );
  }
}
