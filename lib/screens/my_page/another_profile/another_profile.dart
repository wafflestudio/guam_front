import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_bottom.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_link.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_top.dart';
import 'package:provider/provider.dart';
import '../../../models/profile.dart';
import '../../../providers/user_auth/authenticate.dart';

class AnotherProfile extends StatefulWidget {
  final Stacks stacksProvider;
  final int userId;

  AnotherProfile({
    this.stacksProvider,
    this.userId,
  });

  @override
  State<StatefulWidget> createState() => AnotherProfileState();
}

class AnotherProfileState extends State<AnotherProfile> {
  Future<Profile> user;

  @override
  void initState() {
    super.initState();
    user = context.read<Authenticate>().getUserProfile(widget.userId);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: user,
      builder: (context, snapshot) {
        if (!context.read<Authenticate>().loading && snapshot.hasData) {
          return Column(
            children: [
              Stack(
                  children: [
                    MyProfileLink(snapshot.data),
                    MyProfileTop(snapshot.data),
                  ]
              ),
              MyProfileBottom(snapshot.data, widget.stacksProvider),
            ],
          );
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

