import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/user_auth/authenticate.dart';
import '../user_auth/sign_out.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();

    return Container(
        child: Center(
      child: Column(
        children: [
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
