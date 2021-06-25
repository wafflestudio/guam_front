import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'notice.dart';
import 'progresses.dart';
import 'threads.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';
import 'board_title.dart';

class Board extends StatelessWidget {
  final Project board;

  Board(this.board);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            BoardTitle(board.title),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Notice(board.notice),
                  Progresses(board.progresses),
                  Threads(board.threads),
                ],
              ),
            )
          ],
        ),
      )
    );
  }
}
