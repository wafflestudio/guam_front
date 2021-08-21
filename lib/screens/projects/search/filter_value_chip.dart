import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class FilterValueChip extends StatelessWidget {
  final String content;
  final bool selected;
  final Function selectValue;

  FilterValueChip({this.content,  this.selected, this.selectValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10),
      child: ChoiceChip(
        label: Text(
          content,
          style: TextStyle(
            fontSize: 12,
            color: selected ? Colors.white : Colors.black,
            fontWeight: selected ? FontWeight.bold : null,
          ),
        ),
        selected: selected,
        backgroundColor: HexColor("#E9E9E9"),
        side: BorderSide(color: HexColor("#979797"), width: 0.5),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 1),
        selectedColor: HexColor("#08951C"),
        onSelected: (val) => selectValue(content),
      ),
    );
  }
}
