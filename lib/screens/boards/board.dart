import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'notice.dart';
import 'progresses.dart';
import 'threads.dart';
import 'package:hexcolor/hexcolor.dart';

class Board extends StatelessWidget {
  final Project board;

  Board(this.board);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Container(
              height: 66,
              color: HexColor('#8EFFA0'),
              child: Center(
                child: Text(
                  board.title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 10,
              ),
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
