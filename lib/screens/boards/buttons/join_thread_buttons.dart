import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/boards/boards.dart';
import 'custom_button.dart';
import 'waiting_button.dart';

class JoinThreadButtons extends StatelessWidget {
  final int userId;
  // final String userState;
  final bool enabled;

  JoinThreadButtons({
    @required this.userId,
    // @required this.userState,
    @required this.enabled
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: enabled
        ? [
          customButton(
            content: "승인",
            color: Color.fromRGBO(8, 149, 28, 1),
            onPressed: () => context.read<Boards>().acceptDecline(userId: userId, accept: true)
          ),
          Padding(padding: EdgeInsets.only(left: 10)),
          customButton(
            content: "반려",
            color: Color.fromRGBO(235, 87, 87, 1),
            onPressed: () => context.read<Boards>().acceptDecline(userId: userId, accept: false)
          )
        ] : [
          WaitingButton()
        ],
      ),
    );
  }
}
