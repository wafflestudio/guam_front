import 'package:flutter/material.dart';
import 'function_container.dart';
import 'package:provider/provider.dart';
import '../../../providers/boards/boards.dart';
class BottomModalContent extends StatelessWidget {
  final Boards boardsProvider;
  final int threadId;

  BottomModalContent({@required this.boardsProvider, @required this.threadId});

  @override
  Widget build(BuildContext context) {
    Future setNotice() async {
      await boardsProvider.setNotice(threadId).then((res) {
        if (res) Navigator.of(context).pop();
      });
    }

    Future deleteThread() async {
      await boardsProvider.deleteThread(threadId).then((res) {
        if (res) Navigator.of(context).pop();
      });
    }

    return Wrap(
      children: [
        Material(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color.fromRGBO(54, 54, 54, 1),
            width: double.infinity,
            child: Column(
              children: [
                FunctionContainer(iconData: Icons.push_pin_outlined, text: "메시지 고정", textColor: Colors.white, customFunction: setNotice),
                FunctionContainer(iconData: Icons.edit_outlined, text: "메시지 편집", textColor: Colors.white),
                FunctionContainer(iconData: Icons.delete_outlined, text: "메시지 삭제", iconColor: Colors.red, textColor: Colors.red, customFunction: deleteThread),
              ],
            ),
          ),
        )
      ],
    );
  }
}
