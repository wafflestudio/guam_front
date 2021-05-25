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
            // Text(authProvider.me.nickname),
            Text(authProvider.me.blogUrl),
            SignOut(),
          ],
        ),
      )
    );
  }
}
