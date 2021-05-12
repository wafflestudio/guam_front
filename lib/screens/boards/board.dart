import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import '../../models/project.dart';
import 'notice.dart';
import 'progresses.dart';
import 'threads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';

class Board extends StatelessWidget {
  final Project board;

  Board(this.board);

  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.read<Boards>();

    return SingleChildScrollView(
      child: Container(
        // height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Slidable(
              actionPane: SlidableStrechActionPane(),
              actionExtentRatio: 0.25,
              child: Container(
                height: 66,
                child: Row(
                  children: [
                    Container(width: 20 ,color: HexColor('#60B2FF')),
                    Expanded(
                        child: ColoredBox(
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
                        )
                    ),
                    Container(width: 20, color: HexColor('#D660FF')),
                  ],
                ),
              ),
              actions: <Widget>[
                IconSlideAction(
                  caption: '이전',
                  color: HexColor('#60B2FF'),
                  icon: Icons.arrow_back_sharp,
                  onTap: () => boardsProvider.prev(),
                ),
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: '다음',
                  color: HexColor('#D660FF'),
                  icon: Icons.arrow_forward_sharp,
                  onTap: () => boardsProvider.next(),
                ),
              ],
            ),
            // Container(
            //   height: 66,
            //   color: HexColor('#8EFFA0'),
            //   child: Center(
            //     child: Text(
            //       board.title,
            //       style: TextStyle(
            //         fontSize: 24,
            //         fontWeight: FontWeight.w700
            //       ),
            //     ),
            //   ),
            // ),
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
