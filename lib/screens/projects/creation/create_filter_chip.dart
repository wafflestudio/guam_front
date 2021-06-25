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
            // 아래 backgroundColor를 project_create_container.dart 색과 통일시키고 싶은데 혼자 말썽이네요
            backgroundColor: HexColor("5E66A6"),
            side: BorderSide(color: HexColor("#979797"), width: 0.5),
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            selectedColor: HexColor("#4694F9"),
            onSelected: (val) => selectKey(content, filterValues),
          )),
    );
  }
}
