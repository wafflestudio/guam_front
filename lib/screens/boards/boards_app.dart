import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../commons/app_bar.dart';
import '../../providers/boards/boards.dart';
import '../../providers/user_auth/authenticate.dart';
import 'boards_body.dart';

class BoardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Authenticate authProvider = context.watch<Authenticate>();

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Boards(authProvider)),
      ],
      child: BoardsAppScaffold(),
    );
  }
}

class BoardsAppScaffold extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/backgrounds/boards-bg.png"),
              fit: BoxFit.cover,
            )
        ),
        child: Scaffold(
          appBar: appBar(
            title: '작업실',
            /*
        leading: IconButton(
            icon: Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {}
        ),
         */
            trailing: IconButton(
                icon: Icon(
                  Icons.notifications_none,
                  color: Colors.black,
                ),
                onPressed: () {}
            ),
          ),
          body: BoardsBody(),
          backgroundColor: Colors.transparent,
        ),
    );
  }
}

