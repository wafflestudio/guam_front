import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/project.dart';
import 'notice.dart';
import 'progresses.dart';
import 'threads.dart';

class Board extends StatelessWidget {
  final Project board;

  Board(this.board);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 12,
        ),
        child: Column(
          children: [
            Notice(board.notice),
            Progresses(board.progresses),
            Threads(board.threads),
          ],
        ),
      )
    );
  }
}
