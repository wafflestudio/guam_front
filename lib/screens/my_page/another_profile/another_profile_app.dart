import 'package:flutter/material.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:provider/provider.dart';

import '../../../commons/custom_app_bar.dart';
import 'another_profile.dart';

class AnotherProfileApp extends StatelessWidget {
  final int userId;

  AnotherProfileApp(this.userId);

  @override
  Widget build(BuildContext context) {
    final stacksProvider = context.read<Stacks>();

    return Scaffold(
      appBar: CustomAppBar(
        title: "프로필",
        leading: Back(),
      ),
      body: AnotherProfile(stacksProvider: stacksProvider, userId: userId),
    );
  }
}
