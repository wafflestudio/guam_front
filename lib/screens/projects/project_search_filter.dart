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
            spacing: 20.0,
            children: filters.asMap().entries.map((entry) {
              int idx = entry.key;
              return buildFilterChip(
                index: idx,
                label: entry.value['label'],
              );
            }).toList(),
          ),
        ),
        if (filterInputs.length > 0)
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Wrap(
                  children: filterInputs.asMap().entries.map((entry) {
                    int idx = entry.key;
                    return buildChoiceChip(
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

  Widget buildFilterChip({int index, String label}) {
    return Transform(
        transform: Matrix4.identity()..scale(1.1),
        child: ChoiceChip(
          label: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.grey[400],
          // side: BorderSide(color: Colors.black45, width: 0.5),
          padding: const EdgeInsets.all(5),
          elevation: 5,
          selected: filterInputs.contains(label),
          selectedColor: Colors.lightGreen,
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

  Widget buildChoiceChip({int index, String label, String choice}) {
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

    return Row(
      children: <Widget>[
        Expanded(
            child: SizedBox(
                height: 50,
                child: ListView(
                  padding: EdgeInsets.only(left: 10),
                  scrollDirection: Axis.horizontal,
                  children: _selectChoice(choice).asMap().entries.map((entry) {
                    int idx = entry.key;
                    return Container(
                      padding: EdgeInsets.only(right: 15),
                      child: _buildChoiceChip(
                          index: idx,
                          label: entry.value['label'],
                          image: (choice == '기술 스택')
                              ? entry.value['image']
                              : null),
                    );
                  }).toList(),
                )))
      ],
    );
  }

  Widget _buildChoiceChip({int index, String label, String image}) {
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
                  backgroundColor: Colors.white,
                  foregroundImage: NetworkImage(image),
                )
              : null,
          padding: EdgeInsets.all(5),
          elevation: 5,
          selected: choiceInputs.contains(label),
          selectedColor: Colors.deepPurpleAccent[50],
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
}
