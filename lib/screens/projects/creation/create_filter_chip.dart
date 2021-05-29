import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateFilterChip extends StatelessWidget {
  final String content;
  final String display;
  final Function selectKey;
  final bool selected;
  final List<String> filterValues;

  CreateFilterChip(
      {this.content,
      this.display,
      this.selectKey,
      this.selected,
      this.filterValues});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
          padding: EdgeInsets.only(left: 10),
          child: ChoiceChip(
            label: Text(
              display,
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
            selected: selected,
            backgroundColor: Colors.deepPurple,
            side: BorderSide(color: HexColor("#979797"), width: 0.5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            selectedColor: HexColor("#4694F9"),
            onSelected: (val) => selectKey(content, filterValues),
          )),
    );
  }
}
