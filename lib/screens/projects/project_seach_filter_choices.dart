import 'package:flutter/material.dart';
import 'project_search_data.dart';

class SearchFilter extends StatefulWidget {
  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  List<String> filterInputs = [];
  List<String> choiceInputs = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 15.0,
            children: filters.asMap().entries.map((entry) {
              int idx = entry.key;
              return buildInputChip(
                index: idx,
                label: entry.value['label'],
              );
            }).toList(),
          ),
        ),
        if (filterInputs.length > 0)
          Column(
            children: <Widget>[
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  spacing: 10.0,
                  runSpacing: 5.0,
                  children: filterInputs.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return buildTechChoiceChip(
                      index: idx,
                      label: entry.value,
                      choice: entry.value,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
      ],
    );
  }

  Widget buildInputChip({int index, String label}) {
    return Transform(
        transform: Matrix4.identity()..scale(1.1),
        child: InputChip(
          label: Text(
            label,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey[200],
          side: BorderSide(color: Colors.black45, width: 0.5),
          padding: const EdgeInsets.all(5),
          selected: filterInputs.contains(label),
          selectedColor: Colors.green[400],
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                filterInputs.add(label);
              } else {
                filterInputs.removeWhere((value) {
                  return value == label;
                });
              }
            });
          },
        ));
  }

  Widget buildChoiceChip({int index, String label, Color color, String image}) {
    return Transform(
        transform: Matrix4.identity()..scale(1.1),
        child: ChoiceChip(
          label: Text(
            label,
            style: TextStyle(
              color: Colors.black,
            ),
          ),
          avatar: (image != null)
              ? CircleAvatar(
                  child: Text(
                    label[0].toUpperCase(),
                  ),
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(image),
                )
              : null,
          backgroundColor: color,
          padding: const EdgeInsets.all(5),
          selected: choiceInputs.contains(label),
          selectedColor: Colors.lightGreen,
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                choiceInputs.add(label);
              } else {
                choiceInputs.removeWhere((value) {
                  return value == label;
                });
              }
            });
          },
        ));
  }

  Widget buildTechChoiceChip({int index, String label, String choice}) {
    _selectChoice(choice) {
      switch (choice) {
        case '기술 스택':
          return techChoices;
        case '잔여 포지션':
          return positionChoices;
        case '활동 기간':
          return periodChoices;
      }
    }

    return Container(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 15.0,
          children: _selectChoice(choice).asMap().entries.map((entry) {
            int idx = entry.key;
            return buildChoiceChip(
                index: idx,
                label: entry.value['label'],
                color: Colors.grey[300],
                image: (choice == '기술 스택') ? entry.value['image'] : null);
          }).toList(),
        ));
  }
}
