import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';
import 'board.dart';
import 'boards_placeholder.dart';

class BoardsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.watch<Boards>();

    return boardsProvider.hasBoards()
        ? Board(boardsProvider.currentBoard)
        : BoardsPlaceHolder();
  }
}
