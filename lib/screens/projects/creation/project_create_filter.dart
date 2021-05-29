import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
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
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(3, 10, 10, 10),
          decoration: BoxDecoration(
            color: Colors.deepPurple,
            border: Border.all(color: HexColor("979797")),
            borderRadius: BorderRadius.circular(20),
          ),
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
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        "인원",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(left: 20),
                        child: headCounter()),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                      child: Text(
                        "기술 스택",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 10),
                      child: Wrap(
                        children: [
                          ...filterValues.map((e) => CreateFilterValueChip(
                                content: e,
                                selected: result[selectedKey] == e,
                                selectValue: selectValue,
                              ))
                        ],
                      ),
                    )
                  ],
                ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 10, left: 30, bottom: 15),
          alignment: Alignment.centerLeft,
          child: Text(
            '포지션',
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
        ),
        position(),
      ],
    );
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

  Widget position() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      decoration: BoxDecoration(
        color: Colors.deepPurple,
        border: Border.all(color: HexColor("979797")),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          if ((result["백엔드"] == null) &
              (result["프론트엔드"] == null) &
              (result["디자이너"] == null))
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(20),
              child: Text(
                "포지션을 선택하여 크루를 구성하세요.",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          if (result["백엔드"] != null)
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "백엔드",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      "${result['백엔드']}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      "$headCount",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ]),
            ),
          if (result["프론트엔드"] != null)
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "프론트엔드",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      "${result['프론트엔드']}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      "$headCount",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ]),
            ),
          if (result["디자이너"] != null)
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "디자이너",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      "${result['디자이너']}",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    Text(
                      "$headCount",
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                  ]),
            ),
        ],
      ),
    );
  }
}
