import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';

class BoardTitle extends StatelessWidget {
  final String title;

  BoardTitle(this.title);

  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.read<Boards>();

    return Slidable(
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
                      title,
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w700
                      ),
                    )
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
          foregroundColor: Colors.white,
          onTap: () => boardsProvider.prev(),
        ),
      ],
      secondaryActions: <Widget>[
        IconSlideAction(
          caption: '다음',
          color: HexColor('#D660FF'),
          icon: Icons.arrow_forward_sharp,
          foregroundColor: Colors.white,
          onTap: () => boardsProvider.next(),
        ),
      ],
    );
  }
}
