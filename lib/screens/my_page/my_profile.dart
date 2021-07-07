import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import '../user_auth/sign_out.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';
import 'make_profile_page.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();
    final stacksProvider = context.read<Stacks>();

    return Container(
      child: Center(
        child: Column(
          children: [
            Text(authProvider.me.nickname ?? ""),
            Text(authProvider.me.githubUrl ?? ""),
            Text(authProvider.me.blogUrl ?? ""),
            //Text(authProvider.me.skills ?? ""),
            Text(authProvider.me.introduction ?? ""),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  child: Text("프로필 수정"),
                  onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => MakeProfilePage(stacksProvider))),
                ),
                SignOut(),
              ],
            )
          ],
        ),
      )
    );
  }
}
