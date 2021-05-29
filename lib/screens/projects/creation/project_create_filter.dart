import 'package:flutter/material.dart';
import 'create_filter_chip.dart';
import 'create_filter_value_chip.dart';

class TechStackFilter extends StatefulWidget {
  final Map filterOptions = {
    '백엔드': [
      '상관 없음',
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
      '상관 없음',
      'React JS',
      'React TS',
      'Swift',
      'Android',
      'React Native',
      'Flutter',
      'Angular',
    ],
    '디자이너': ['상관 없음', 'Adobe XD', 'Figma', 'Sketch']
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
    print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
      children: [
        Row(children: [
          ...widget.filterOptions.entries.map((e) => CreateFilterChip(
              content: e.key,
              display: e.key,
              selected: selectedKey == e.key,
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
                  padding: EdgeInsets.only(left: 20), child: headCounter()),
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 0, 10),
                child: Text(
                  "기술 스택",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(left: 10),
                  child: SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, idx) => CreateFilterValueChip(
                          content: filterValues[idx],
                          selected: result[selectedKey] == filterValues[idx],
                          selectValue: selectValue,
                        ),
                        itemCount: filterValues.length,
                      )))
            ],
          ),
      ],
    ));
  }

  Widget headCounter() {
    return Row(
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          child: RawMaterialButton(
            shape: CircleBorder(
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            elevation: 5.0,
            fillColor: Colors.white24,
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: minus,
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            "$headCount",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Container(
          width: 36.0,
          height: 36.0,
          child: RawMaterialButton(
            shape: CircleBorder(
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            elevation: 5.0,
            fillColor: Colors.white24,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: add,
          ),
        ),
      ],
    );
  }
}
