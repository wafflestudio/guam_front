import 'package:flutter/material.dart';
import 'function_container.dart';

class BottomModalContent extends StatelessWidget {
  final String setText;
  final String editText;
  final String deleteText;
  final String completeText;
  final String deleteDetailText;
  final String completeDetailText;
  final Function setFunc;
  final Function editFunc;
  final Function deleteFunc;
  final Function completeFunc;
  final bool requireConfirm;

  BottomModalContent({
    this.setText, this.editText, this.deleteText, this.deleteDetailText, this.completeText, this.completeDetailText, this.setFunc, this.editFunc, this.deleteFunc, this.completeFunc, this.requireConfirm = false});

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
                if (setFunc != null) FunctionContainer(iconData: Icons.push_pin_outlined, text: setText, textColor: Colors.white, customFunction: setFunc),
                if (editFunc != null) FunctionContainer(iconData: Icons.edit_outlined, text: editText, textColor: Colors.white, customFunction: editFunc),
                if (completeFunc != null) FunctionContainer(iconData: Icons.flag_outlined, text: completeText, detailText: completeDetailText, iconColor: Colors.blue, textColor: Colors.blue, customFunction: completeFunc, requireConfirm: requireConfirm),
                if (deleteFunc != null) FunctionContainer(iconData: Icons.delete_outlined, text: deleteText, detailText: deleteDetailText, iconColor: Colors.red, textColor: Colors.red, customFunction: deleteFunc, requireConfirm: requireConfirm),
              ],
            ),
          ),
        )
      ],
    );
  }
}
