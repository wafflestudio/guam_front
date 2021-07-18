import 'package:flutter/material.dart';
import 'function_container.dart';
import 'package:provider/provider.dart';
import '../../../providers/boards/boards.dart';
class BottomModalContent extends StatelessWidget {
  final Function setFunc;
  final Function editFunc;
  final Function deleteFunc;

  BottomModalContent({this.setFunc, this.editFunc, this.deleteFunc});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Material(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color.fromRGBO(54, 54, 54, 1),
            width: double.infinity,
            child: Column(
              children: [
                if (setFunc != null) FunctionContainer(iconData: Icons.push_pin_outlined, text: "메시지 고정", textColor: Colors.white, customFunction: setFunc),
                if (editFunc != null) FunctionContainer(iconData: Icons.edit_outlined, text: "메시지 편집", textColor: Colors.white, customFunction: editFunc),
                if (deleteFunc != null) FunctionContainer(iconData: Icons.delete_outlined, text: "메시지 삭제", iconColor: Colors.red, textColor: Colors.red, customFunction: deleteFunc),
              ],
            ),
          ),
        )
      ],
    );
  }
}
