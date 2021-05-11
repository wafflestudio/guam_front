import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../commons/app_bar.dart';
import '../../providers/boards/boards.dart';
import '../../providers/user_auth/authenticate.dart';
import 'boards_body.dart';

class BoardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Boards(authToken: context.read<Authenticate>().authToken)),
      ],
      child: BoardsAppScaffold(),
    );
  }
}

class BoardsAppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: '작업실',
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.white,
            ),
            onPressed: () {}
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
            onPressed: () {}
        ),
      ),
      body: BoardsBody(),
    );
  }
}

