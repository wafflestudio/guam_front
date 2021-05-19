import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchFilter extends StatefulWidget {
  const SearchFilter({Key key}) : super(key: key);

  @override
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  int _selectedFilter;
  int _selectedTech;
  int _selectedPosition;
  int _selectedPeriod;
  Map _filterOptions = {
    '기술 스택': [
      'Flutter',
      'SpringBoot',
      'Django',
      'React',
      'Swift',
      'ReactNative'
    ],
    '포지션': ['백엔드', '프론트엔드', '디자이너'],
    '활동 기간': ['1개월 미만', '3개월 미만', '6개월 미만', '6개월 이상']
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      child: buildFilterChips(_filterOptions.keys.toList()),
    );
  }

  Widget filterChip(List<dynamic> _options, int _selectedChoice) {
    return ChoiceChip(
        label: Text(
          _options[_selectedChoice],
          style: TextStyle(
            fontSize: 12,
            color: (_selectedFilter == _selectedChoice)
                ? Colors.white
                : Colors.black,
            fontWeight:
                (_selectedFilter == _selectedChoice) ? FontWeight.bold : null,
          ),
        ),
        selected: _selectedFilter == _selectedChoice,
        backgroundColor: HexColor("#E9E9E9"),
        side: BorderSide(color: HexColor("#979797"), width: 0.5),
        padding: EdgeInsets.all(5),
        selectedColor: HexColor("#08951C"),
        onSelected: (bool selected) {
          setState(() {
            if (selected) {
              _selectedFilter = _selectedChoice;
            }
          });
        });
  }

  Widget buildFilterChips(List<dynamic> _options) {
    List<Widget> chips = [];
    for (int i = 0; i < _options.length; i++) {
      chips.add(Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: filterChip(_options, i)));
    }
    return Column(children: [
      Row(
        children: chips,
      ),
      (_selectedFilter != null)
          ? _buildChoiceChip(_selectedFilter)
          : Container()
    ]);
  }

  Widget buildChoiceChips(List<String> _options) {
    List<Widget> chips = [];
    if (_selectedFilter == 0) {
      for (int i = 0; i < _options.length; i++) {
        ChoiceChip choiceChip = ChoiceChip(
          selected: _selectedTech == i,
          label: Text(
            _options[i],
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          backgroundColor: HexColor("#E9E9E9"),
          side: BorderSide(color: HexColor("#979797"), width: 0.5),
          selectedColor: HexColor("#08951C"),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedTech = i;
              }
            });
          },
        );
        chips.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 7), child: choiceChip));
      }
    }

    if (_selectedFilter == 1) {
      for (int i = 0; i < _options.length; i++) {
        ChoiceChip choiceChip = ChoiceChip(
          selected: _selectedPosition == i,
          label: Text(
            _options[i],
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          backgroundColor: HexColor("#E9E9E9"),
          side: BorderSide(color: HexColor("#979797"), width: 0.5),
          selectedColor: HexColor("#08951C"),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedPosition = i;
              }
            });
          },
        );
        chips.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 7), child: choiceChip));
      }
    }
    if (_selectedFilter == 2) {
      for (int i = 0; i < _options.length; i++) {
        ChoiceChip choiceChip = ChoiceChip(
          selected: _selectedPeriod == i,
          label: Text(
            _options[i],
            style: TextStyle(
              fontSize: 12,
              color: Colors.black,
            ),
          ),
          backgroundColor: HexColor("#E9E9E9"),
          side: BorderSide(color: HexColor("#979797"), width: 0.5),
          selectedColor: HexColor("#08951C"),
          onSelected: (bool selected) {
            setState(() {
              if (selected) {
                _selectedPeriod = i;
              }
            });
          },
        );
        chips.add(Padding(
            padding: EdgeInsets.symmetric(horizontal: 7), child: choiceChip));
      }
    }

    return Column(children: [
      SizedBox(
        height: 40,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: chips,
        ),
      )
    ]);
  }

  Widget _buildChoiceChip(int _selectedFilter) {
    return Container(
        child:
            buildChoiceChips(_filterOptions.values.elementAt(_selectedFilter)));
  }
}
