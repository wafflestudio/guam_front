import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/boards/boards.dart';

class UnexpandedTitleContainer extends StatelessWidget {
  final Color color;
  final int idx; // Needed for calculating 'render board idx' and 'margin'

  UnexpandedTitleContainer({this.color, this.idx});

  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.read<Boards>();

    return InkWell(
      child: Container(
        margin: EdgeInsets.only(left: idx != 0 ? 12 : 0),
        width: 26,
        height: 26,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: color,
        )
      ),
      onTap: () => boardsProvider.renderBoardIdx = idx,
    );
  }
}
