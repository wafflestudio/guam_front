import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class TechStacksMultiSelectChip extends StatefulWidget {
  final List<String> reportList;
  final Function(List<String>) onSelectionChanged;

  TechStacksMultiSelectChip(this.reportList, {this.onSelectionChanged});

  @override
  _TechStacksMultiSelectChipState createState() =>
      _TechStacksMultiSelectChipState();
}

class _TechStacksMultiSelectChipState extends State<TechStacksMultiSelectChip> {
  List<String> selectedChoices = [];

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.reportList.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item,
              style: (selectedChoices.contains(item))
                  ? TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  : TextStyle(fontSize: 12, color: Colors.black)),
          selected: selectedChoices.contains(item),
          selectedColor: HexColor("#08951C"),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }
}
