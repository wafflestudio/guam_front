import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';
import 'board.dart';

class BoardsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.watch<Boards>();

    return boardsProvider.boards != null && boardsProvider.boards.length != 0
        ? Board(boardsProvider.boards[boardsProvider.renderBoardIdx])
        : Container(child: Center(child: Text("참여중인 프로젝트가 없습니다")));
  }
}
