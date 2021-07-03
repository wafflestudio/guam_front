import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'notice.dart';
import 'tasks.dart';
import 'threads.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';
import 'board_title.dart';

class Board extends StatelessWidget {
  final Project board;

  Board(this.board);

  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.watch<Boards>();

    if (!board.hasBoardData()) {
      boardsProvider.fetchBoard(board.id);
    }

    return SingleChildScrollView(
      child: Container(
        child: boardsProvider.loading
            ? Center(child: CircularProgressIndicator())
            : Column(
              children: [
                BoardTitle(board.title),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      //Notice(board.notice),
                      Tasks(board.tasks),
                      Threads(board.threads),
                    ],
                  ),
                )
              ],
        )
      )
    );
  }
}
