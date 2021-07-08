import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/boards/boards.dart';

class ExpandedTitleContainer extends StatelessWidget {
  final Color color;
  final int idx; // Needed for calculating 'margin'

  ExpandedTitleContainer({this.color, this.idx});

  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.read<Boards>();

    return Expanded(
        child: Container(
          margin: EdgeInsets.only(left: idx != 0 ? 12 : 0),
          child: DecoratedBox(
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      boardsProvider.currentBoard.title,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700
                      ),
                    ),
                  )
              )
          ),
        )
    );
  }
}
