import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';

class AcceptDenyButton extends StatelessWidget {
  final int guestId;

  AcceptDenyButton({@required this.guestId});

  @override
  Widget build(BuildContext context) {
    Widget customButton(String content, Color color, bool isAccept) {
      return InkWell(
        onTap: () => context.read<Boards>().acceptDenyGuest(guestId: guestId, accept: isAccept),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            child: Text(
              content,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          customButton("승인", Color.fromRGBO(8, 149, 28, 1), true),
          Padding(padding: EdgeInsets.only(left: 10)),
          customButton("반려", Color.fromRGBO(235, 87, 87, 1), false)
        ],
      ),
    );
  }
}