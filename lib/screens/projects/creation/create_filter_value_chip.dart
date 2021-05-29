import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateFilterValueChip extends StatelessWidget {
  final String content;
  final bool selected;
  final Function selectValue;

  CreateFilterValueChip({this.content,  this.selected, this.selectValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 8),
      child: ChoiceChip(
        label: Text(
          content,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : Colors.black,
          ),
        ),
        selected: selected,
        backgroundColor: HexColor("#E9E9E9"),
        side: BorderSide(color: HexColor("#979797"), width: 1),
        selectedColor: HexColor("#4694F9"),
        onSelected: (val) => selectValue(content),
      ),
    );
  }
}
