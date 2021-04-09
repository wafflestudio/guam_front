import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';

class SignOut extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        child: const Text('로그아웃'),
        onPressed: () {
          context.read<Authenticate>()
              .signOut(authToken: context.read<Authenticate>().authToken)
              .then((response) => context.read<Authenticate>().destroyAuthToken())
              .then((val) => Navigator.of(context).popUntil((route) => route.isFirst));
        }
    );
  }
}
