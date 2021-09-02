import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'notice/notice.dart';
import 'tasks/tasks.dart';
import 'threads/threads.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';
import 'board_title/board_title.dart';
import '../../commons/common_sizes.dart';

class Board extends StatefulWidget {
  final Project board;

  Board(this.board);

  @override
  State<StatefulWidget> createState() => BoardState();
}

class BoardState extends State<Board> {
  ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.watch<Boards>();

    if (!widget.board.hasBoardData()) {
      boardsProvider.fetchBoard(widget.board.id);
    }

    void scrollBottom() {
      _controller.animateTo(
        boardsBodyHeight(context),
        duration: Duration(milliseconds: 500),
        curve: Curves.easeOut
      );
    }

    return !boardsProvider.loading
        ? SingleChildScrollView(
            controller: _controller,
            child: Container(
                child: Column(
                  children: [
                    BoardTitle(),
                    Padding(
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Notice(widget.board.notice),
                          Tasks(widget.board.tasks),
                          Threads(
                            widget.board.threads,
                            onUnfoldThreads: scrollBottom,
                          ),
                        ],
                      ),
                    )
                  ],
                )
            )
        )
        : Container(child: Center(child: CircularProgressIndicator()));
  }
}
