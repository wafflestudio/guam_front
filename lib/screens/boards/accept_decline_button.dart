import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';

class AcceptDeclineButton extends StatelessWidget {
  final int userId;
  final String userState;
  final bool enabled;

  AcceptDeclineButton({@required this.userId, @required this.userState, @required this.enabled});

  @override
  Widget build(BuildContext context) {
    Widget customButton(String content, Color color, bool isAccept) {
      return ConstrainedBox(
        constraints: BoxConstraints(maxHeight: 28),
        child: ElevatedButton(
          onPressed: () {
            if (enabled) context.read<Boards>().acceptDecline(userId: userId, accept: isAccept);
          },
          style: ElevatedButton.styleFrom(
            primary: color,
            padding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            child: Text(
              content,
              style: TextStyle(color: Colors.white),
            ),
          )
        )
      );
    }

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          if (userState == "GUEST") customButton("승인", enabled ? Color.fromRGBO(8, 149, 28, 1) : Colors.grey, true),
          if (userState == "GUEST") Padding(padding: EdgeInsets.only(left: 10)),
          customButton("반려", enabled ? Color.fromRGBO(235, 87, 87, 1) : Colors.grey, false)
        ],
      ),
    );
  }
}
