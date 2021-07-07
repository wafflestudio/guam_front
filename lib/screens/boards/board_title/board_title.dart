import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/boards/boards.dart';
import 'expanded_title_container.dart';
import 'unexpanded_title_container.dart';

class BoardTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.read<Boards>();

    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 40,

        child: Row(
          children: [
            ...boardsProvider.boards.asMap().keys.map((idx) {
              return boardsProvider.renderBoardIdx == idx
                  ? ExpandedTitleContainer(color: boardsProvider.renderBoardColor[idx], idx: idx)
                  : UnexpandedTitleContainer(color: boardsProvider.renderBoardColor[idx], idx: idx);
            })
          ],
        ),
      ),
    );
  }
}
