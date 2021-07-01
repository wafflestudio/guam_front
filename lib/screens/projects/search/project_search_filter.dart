import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:hexcolor/hexcolor.dart';
import 'search_filter_chip.dart';
import 'filter_value_chip.dart';

class SearchFilter extends StatefulWidget {
  final Stacks stacksProvider;

  SearchFilter(this.stacksProvider);

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
    final Map filterOptions = {
      '기술 스택': List<String>.from(
          widget.stacksProvider.stacks.map((stack) => stack.name)),
      '포지션': ['백엔드', '프론트엔드', '디자이너'],
      '활동 기간': ['1개월 미만', '3개월 미만', '6개월 미만', '6개월 이상']
    };

    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: HexColor("979797"),
          ),
        ),
        padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
        child: Column(
          children: [
            Row(children: [
              ...filterOptions.entries.map((e) => SearchFilterChip(
                  content: e.key,
                  display: result[e.key] != null
                      ? "${e.key}: ${result[e.key]}"
                      : e.key,
                  selected: selectedKey == e.key,
                  selectKey: selectKey,
                  filterValues: e.value))
            ]),
            if (selectedKey != null)
              SizedBox(
                  height: 40,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, idx) => FilterValueChip(
                      content: filterValues[idx],
                      selected: result[selectedKey] == filterValues[idx],
                      selectValue: selectValue,
                    ),
                    itemCount: filterValues.length,
                  ))
          ],
        ));
  }
}
