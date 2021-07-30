import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../create_filter_chip.dart';
import '../create_filter_value_chip.dart';
import '../../../../helpers/translate.dart';
import '../../../../models/stack.dart' as StackModel;

class ProjectCreatePositions extends StatefulWidget {
  final Map input;
  final Map<dynamic, List<dynamic>> filterOptions;

  ProjectCreatePositions({this.input, this.filterOptions});

  @override
  _ProjectCreatePositionsState createState() => _ProjectCreatePositionsState();
}

class _ProjectCreatePositionsState extends State<ProjectCreatePositions> {
  String selectedKey;
  List<StackModel.Stack> filterValues;

  @override
  Widget build(BuildContext context) {
    print("24: ${widget.input}");

    return Column(
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(3, 10, 10, 10),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor("979797")),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(children: [
                  ...widget.filterOptions.entries.map((e) => CreateFilterChip(
                      content: e.key,
                      display: translate(e.key),
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
                            ...filterValues.map((e) {
                              return CreateFilterValueChip(
                                stack: e,
                                selected: widget.input[selectedKey]["stack"] == e.name,
                                selectValue: selectValue,
                              );
                            })
                          ],
                        ),
                      )
                    ],
                  ),
              ],
            )),
        Container(
            padding: EdgeInsets.only(top: 10, left: 5, bottom: 5),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Text(
                    '포지션',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                //position(widget.filterOptions),
              ],
            )),
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
            onPressed: () => {
              if (selectedKey != null) minusHeadcount(selectedKey),
            },
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            widget.input[selectedKey]["headcount"].toString(),
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
              if (selectedKey != null) addHeadcount(selectedKey),
            },
          ),
        ),
      ],
    );
  }

  Widget position(Map<dynamic, List<dynamic>> filterOptions) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
        decoration: BoxDecoration(
          border: Border.all(color: HexColor("979797")),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          if ((widget.input["BACKEND"]["stack"] == '') &
              (widget.input["FRONTEND"]["stack"] == '') &
              (widget.input["DESIGNER"]["stack"] == ''))
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(20),
              child: Text(
                "포지션을 선택하여 크루를 구성하세요.",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          if ((widget.input["BACKEND"]["stack"] != '') ||
              (widget.input["FRONTEND"]["stack"] != '') ||
              (widget.input["DESIGNER"]["stack"] != ''))
            Wrap(
              children: [
                ...filterOptions.entries.map((e) =>
                    (widget.input[e.key]["stack"].toString() != '')
                        ? Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    e.key.toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  Text(
                                    widget.input[e.key.toString()]["stack"]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                  Text(
                                    widget.input[e.key.toString()]["headcount"]
                                        .toString(),
                                    style: TextStyle(
                                        fontSize: 14, color: Colors.white),
                                  ),
                                ]))
                        : Container())
              ],
            ),
        ]));
  }

  void addHeadcount(tech) {
    setState(() {
      widget.input[tech]["headcount"]++;
    });
  }

  void minusHeadcount(tech) {
    setState(() {
      if (widget.input[tech]["headcount"] > 0)
        widget.input[tech]["headcount"]--;
    });
  }

  void selectKey(String key, List<StackModel.Stack> value) {
    setState(() {
      selectedKey = selectedKey == key ? null : key;
      filterValues = value;
    });
  }

  void selectValue(StackModel.Stack stack) {
    setState(() {
      widget.input[selectedKey]["id"] = stack.id;
      widget.input[selectedKey]["stack"] = stack.name;
    });
  }
}
