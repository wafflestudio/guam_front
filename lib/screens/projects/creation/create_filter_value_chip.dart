import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../models/stack.dart' as StackModel;

class CreateFilterValueChip extends StatelessWidget {
  final StackModel.Stack stack;
  final bool selected;
  final Function selectValue;

  CreateFilterValueChip({this.stack, this.selected, this.selectValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 5),
      child: ChoiceChip(
        label: Text(
          stack.name,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
        selected: selected,
        backgroundColor: HexColor("#E9E9E9"),
        side: BorderSide(color: HexColor("#979797"), width: 1),
        selectedColor: HexColor("#4694F9"),
        onSelected: (val) => selectValue(stack),
      ),
    );
  }
}
