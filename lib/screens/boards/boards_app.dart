import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../commons/custom_app_bar.dart';
import '../../providers/boards/boards.dart';
import '../../providers/user_auth/authenticate.dart';
import 'boards_body.dart';
import 'quit_board.dart';

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
    return Scaffold(
      appBar: CustomAppBar(
        title: '작업실',
        trailing: QuitBoard(),
      ),
      body: BoardsBody(),
      backgroundColor: Colors.transparent,
    );
  }
}

