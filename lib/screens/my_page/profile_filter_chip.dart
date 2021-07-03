import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProfileFilterChip extends StatelessWidget {
  final String content;
  final String display;
  final Function selectKey;
  final bool selected;
  final List<String> filterValues;

  ProfileFilterChip(
      {this.content,
      this.display,
      this.selectKey,
      this.selected,
      this.filterValues});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: ChoiceChip(
      shape: RoundedRectangleBorder(
        // borderRadius: BorderRadius.all(Radius.circular(10))
        borderRadius: (display == '백엔드')
            ? BorderRadius.only(
                topLeft: Radius.circular(10), bottomLeft: Radius.circular(10))
            : ((display == '디자이너')
                ? BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))
                : BorderRadius.zero),
      ),
      label: Text(
        display,
        style: (selected)
            ? TextStyle(
                fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)
            : TextStyle(fontSize: 14, color: Colors.black),
      ),
      selected: selected,
      backgroundColor: Colors.white,
      side: BorderSide(color: HexColor("#979797"), width: 0.5),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      selectedColor: HexColor("#85DC40"),
      onSelected: (val) => selectKey(content, filterValues),
    ));
  }
}
