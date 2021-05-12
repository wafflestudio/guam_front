import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/project.dart';
import 'package:hexcolor/hexcolor.dart';
import 'notice.dart';

class Board extends StatelessWidget {
  final Project board;

  Board(this.board);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10,
        vertical: 12,
      ),
      child: Column(
        children: [
          Notice(board.notice),
        ],
      ),
    );
  }
}
