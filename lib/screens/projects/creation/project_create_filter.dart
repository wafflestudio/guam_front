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
  String selectedKey;
  List<String> filterValues;
  Map input = {
    '백엔드': {'stack': '', 'headcount': 0},
    '프론트엔드': {'stack': '', 'headcount': 0},
    '디자이너': {'stack': '', 'headcount': 0},
  };

  void add(tech) {
    setState(() {
      input[tech]["headcount"]++;
    });
  }

  void minus(tech) {
    setState(() {
      if (input[tech]["headcount"] > 0) input[tech]["headcount"]--;
    });
  }

  void selectKey(String key, List<String> value) {
    setState(() {
      selectedKey = selectedKey == key ? null : key;
      filterValues = value;
    });
  }

  void selectValue(String value) {
    setState(() => input[selectedKey]["stack"] = value);
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
                                selected: input[selectedKey]["stack"] == e,
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
            onPressed: () => {if (selectedKey != null) minus(selectedKey)},
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            input[selectedKey]["headcount"].toString(),
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
            onPressed: () => {
              if (selectedKey != null) add(selectedKey),
            },
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
        child: Column(children: [
          if ((input["백엔드"]["stack"] == '') &
              (input["프론트엔드"]["stack"] == '') &
              (input["디자이너"]["stack"] == ''))
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(20),
              child: Text(
                "포지션을 선택하여 크루를 구성하세요.",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          if ((input["백엔드"]["stack"] != '') ||
              (input["프론트엔드"]["stack"] != '') ||
              (input["디자이너"]["stack"] != ''))
            Wrap(
              children: [
                ...input.entries.map((e) => (input[e.key.toString()]["stack"]
                            .toString() !=
                        '')
                    ? Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                e.key.toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Text(
                                input[e.key.toString()]["stack"].toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                              Text(
                                input[e.key.toString()]["headcount"].toString(),
                                style: TextStyle(
                                    fontSize: 14, color: Colors.white),
                              ),
                            ]))
                    : Container())
              ],
            ),
        ]));
  }
}
