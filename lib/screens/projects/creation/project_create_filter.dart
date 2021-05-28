import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/search/filter_value_chip.dart';
import 'package:guam_front/screens/projects/search/search_filter_chip.dart';

class TechStackFilter extends StatefulWidget {
  final Map filterOptions = {
    '백엔드': [
      'SpringBoot',
      'JPA',
      'Django',
      'express',
      'Ruby on Rails',
      'node.js',
      'Laravel',
      '상관 없음'
    ],
    '프론트엔드': [
      'React JS',
      'React TS',
      'Swift',
      'Android',
      'React Native',
      'Flutter',
      'Angular',
      '상관 없음'
    ],
    '디자이너': ['Adobe XD', 'Figma', 'Sketch', '상관 없음']
  };

  @override
  _TechStackFilterState createState() => _TechStackFilterState();
}

class _TechStackFilterState extends State<TechStackFilter> {
  Map result = {};
  String selectedKey;
  List<String> filterValues;
  int headCount = 0;

  void add() {
    setState(() {
      headCount++;
    });
  }

  void minus() {
    setState(() {
      if (headCount != 0) headCount--;
    });
  }

  void selectKey(String key, List<String> value) {
    setState(() {
      selectedKey = selectedKey == key ? null : key;
      filterValues = value;
    });
  }

  void selectValue(String value) {
    setState(() => result[selectedKey] = value);
    print(result); // 현재 filter choice 상태를 반영합니다.
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(children: [
          ...widget.filterOptions.entries.map((e) => SearchFilterChip(
              content: e.key,
              display:
                  result[e.key] != null ? "${e.key}: ${result[e.key]}" : e.key,
              selected: selectedKey == e.key,
              selectedColor: "#4694F9",
              selectKey: selectKey,
              filterValues: e.value))
        ]),
        if (selectedKey != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                child: Text(
                  "인원",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      FloatingActionButton(
                        onPressed: minus,
                        child: Icon(
                          Icons.remove,
                          color: Colors.white,
                          size: 18,
                        ),
                        backgroundColor: Colors.white24,
                      ),
                      Text('$headCount',
                          style: TextStyle(fontSize: 18, color: Colors.white)),
                      FloatingActionButton(
                        onPressed: add,
                        child: Icon(
                          Icons.add,
                          color: Colors.white,
                        ),
                        backgroundColor: Colors.white24,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                child: Text(
                  "기술 스택",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
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
          )
      ],
    ));
  }
}
