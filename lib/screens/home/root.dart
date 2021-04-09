import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../providers/home/home_provider.dart';
import '../user_auth/auth.dart';
import 'home.dart';

class Root extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authToken = context.watch<Authenticate>().authToken;

    if (authToken == null || authToken == '') {
      return Auth();
    } else {
      return ChangeNotifierProvider(
        create: (_) => HomeProvider(),
        child: Home(),
      );
    }
  }
}
