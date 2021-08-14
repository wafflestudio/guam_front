import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/profiles/profile_bottom.dart';
import 'package:guam_front/screens/profiles/profile_link.dart';
import 'package:guam_front/screens/profiles/profile_top.dart';
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
        if (snapshot.hasData) {
          return Column(
            children: [
              Stack(
                children: [
                  ProfileLink(snapshot.data),
                  ProfileTop(snapshot.data),
                ]
              ),
              ProfileBottom(snapshot.data, widget.stacksProvider),
              Container(
                padding: EdgeInsets.only(bottom: 20),
                color: Colors.white,
              )
            ],
          );
        } else {
          return SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: CircularProgressIndicator()
            )
          );
        }
      },
    );
  }
}

