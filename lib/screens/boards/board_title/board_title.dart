import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/boards/boards.dart';
import 'expanded_title_container.dart';
import 'unexpanded_title_container.dart';

class BoardTitle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.read<Boards>();

    Map<int, Color> renderBoardColor = {
      0: Color.fromRGBO(112, 255, 0, 0.6),
      1: Color.fromRGBO(0, 141, 232, 0.6),
      2: Color.fromRGBO(255, 179, 116, 1),
    };

    return Padding(
      padding: EdgeInsets.all(10),
      child: Container(
        height: 40,

        child: Row(
          children: [
            ...boardsProvider.boards.asMap().keys.map((idx) {
              return boardsProvider.renderBoardIdx == idx
                  ? ExpandedTitleContainer(color: renderBoardColor[idx], idx: idx)
                  : UnexpandedTitleContainer(color: renderBoardColor[idx], idx: idx);
            })
          ],
        ),
      ),
    );
  }
}
