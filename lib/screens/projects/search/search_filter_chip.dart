import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchFilterChip extends StatelessWidget {
  final String content;
  final String display;
  final Function selectKey;
  final bool selected;
  final List<String> filterValues;

  SearchFilterChip({this.content, this.display, this.selectKey, this.selected, this.filterValues});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 10),
          child: ChoiceChip(
            label: Text(
              display,
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
            onSelected: (val) => selectKey(content, filterValues),
          )
        ),
      ],
    );
  }
}
