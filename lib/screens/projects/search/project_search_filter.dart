import 'package:flutter/material.dart';
import 'search_filter_chip.dart';
import 'filter_value_chip.dart';

class SearchFilter extends StatefulWidget {
  final Map filterOptions = {
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
  _SearchFilterState createState() => _SearchFilterState();
}

class _SearchFilterState extends State<SearchFilter> {
  Map result = {};
  String selectedKey;
  List<String> filterValues;

  void selectKey(String key, List<String> value) {
    setState(() {
      selectedKey = selectedKey == key ? null : key;
      filterValues = value;
    });
  }

  void selectValue(String value) {
    setState(() => result[selectedKey] = value);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [...widget.filterOptions.entries.map((e) =>
              SearchFilterChip(
                content: e.key,
                display: result[e.key] != null ? "${e.key}: ${result[e.key]}" : e.key,
                selected: selectedKey == e.key,
                selectKey: selectKey,
                filterValues: e.value
              )
            )]
          ),
          if (selectedKey != null) SizedBox(
            height: 40,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, idx) => FilterValueChip(
                content: filterValues[idx],
                selected: result[selectedKey] == filterValues[idx],
                selectValue: selectValue,
              ),
              itemCount: filterValues.length,
            )
          )
        ],
      )
    );
  }
}
