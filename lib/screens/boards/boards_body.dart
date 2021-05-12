import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';
import 'board.dart';

class BoardsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final PageController boardsController = PageController(initialPage: 0);
    final boardsProvider = context.watch<Boards>();

    // return PageView(
    //   scrollDirection: Axis.horizontal,
    //   controller: boardsController,
    //   children: [...boardsProvider.boards.map((e) => Board(e))],
    // );
    return Board(boardsProvider.boards[boardsProvider.renderBoardIdx]);
  }
}
