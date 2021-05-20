import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchFilterChip extends StatelessWidget {
  final String content;
  final Function selectKey;
  final bool selected;

  SearchFilterChip({this.content, this.selectKey, this.selected});

  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
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
      padding: EdgeInsets.all(5),
      selectedColor: HexColor("#08951C"),
      onSelected: (val) => selectKey(content),
    );
  }
}
