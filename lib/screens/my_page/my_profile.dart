import 'package:flutter/material.dart';
import '../user_auth/sign_out.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.read<Authenticate>();

    return Container(
      child: Center(
        child: Column(
          children: [
            Text('내 프로필 정보 보여주는 페이지', style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800)),
            Text(authProvider.me.nickname ?? ""),
            Text(authProvider.me.githubUrl ?? ""),
            Text(authProvider.me.blogUrl ?? ""),
            //Text(authProvider.me.skills ?? ""),
            Text(authProvider.me.introduction ?? ""),
            SignOut(),
          ],
        ),
      )
    );
  }
}
