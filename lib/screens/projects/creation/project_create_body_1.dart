import 'package:flutter/material.dart';
import 'package:guam_front/commons/next_page.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:guam_front/screens/projects/creation/project_create_body_2.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateProjectBoardOne extends StatefulWidget {
  final Map _periodOptions = {1: '주', 2: '월'};

  @override
  _CreateProjectBoardOneState createState() => _CreateProjectBoardOneState();
}

class _CreateProjectBoardOneState extends State<CreateProjectBoardOne> {
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  int _value = 1;
  double _period = 1;
  Map input = {
    'title': '',
    'period': '',
    'description': '',
    'backend': {'stack': '', 'headcount': ''},
    'frontend': {'stack': '', 'headcount': ''},
    'designer': {'stack': '', 'headcount': ''},
    'myPosition': '',
    'projectPicture': ''
  };

  void _saveTitle(_projectName) {
    setState(() {
      input["title"] = _projectName;
    });
  }

  void _savePeriod(_projectPeriod) {
    setState(() {
      input["period"] = _projectPeriod;
    });
  }

  void _saveDescription(_projectDescription) {
    setState(() {
      input["description"] = _projectDescription;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5),
        child: ProjectCreateContainer(
          content: Column(
            children: [
              Container(
                alignment: Alignment.center,
                child: Container(
                  width: 100,
                  height: 5,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
                alignment: Alignment.centerLeft,
                child: Text(
                  '1. 프로젝트 아웃라인',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              projectTitle(_projectNameController),
              projectPeriod(),
              projectDescription(_projectDescriptionController),
              Expanded(
                  child: Align(
                alignment: FractionalOffset.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    NextPage(
                      nextPage: CreateProjectBoardTwo(),
                      text: '다음',
                      buttonWidth: MediaQuery.of(context).size.width * 0.9,
                    ),
                  ],
                ),
              )),
              ProjectStatus(totalPage: 3, currentPage: 1)
            ],
          ),
        ));
  }

  Widget projectTitle(TextEditingController _nameController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 30, bottom: 15),
            child: Text('제목',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ))),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 50,
          child: TextFormField(
            onChanged: (_projectName) {
              setState(() {
                _saveTitle(_projectName);
              });
            },
            controller: _nameController,
            style: TextStyle(fontSize: 14, color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white24,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: "프로젝트 이름을 입력하세요.",
                hintStyle: TextStyle(fontSize: 14, color: Colors.white)),
            validator: (String value) {
              if (value.isEmpty) {
                return "프로젝트 이름을 입력하지 않았습니다.";
              }
              if (value.length > 2) {
                return "프로젝트 이름은 최소한 두 글자 이상이어야 합니다.";
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  Widget projectPeriod() {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 30),
                child: Text('진행 기간',
                    style: TextStyle(fontSize: 18, color: Colors.white))),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 7),
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: SliderTheme(
                      data: SliderThemeData(
                          trackHeight: 1.5,
                          activeTrackColor: HexColor('7EE7E6'),
                          thumbColor: Colors.white,
                          inactiveTrackColor: Colors.white24,
                          activeTickMarkColor: Colors.white,
                          valueIndicatorColor: Colors.white,
                          valueIndicatorTextStyle:
                              TextStyle(color: Colors.black, fontSize: 14),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12)),
                      child: Slider(
                          min: 1,
                          max: 10,
                          divisions: 9,
                          value: _period,
                          onChanged: (_newPeriod) {
                            setState(() {
                              _period = _newPeriod;
                              _savePeriod(_newPeriod);
                            });
                          }),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white24,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        _period.round().toString(),
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    Wrap(children: [
                      ...widget._periodOptions.entries.map((e) => FilterChip(
                            label: Text(
                              '${e.value}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            showCheckmark: false,
                            side: BorderSide(color: Colors.white, width: 0.5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 1),
                            selected: _value == e.key,
                            selectedColor: HexColor('4694F9'),
                            onSelected: (bool selected) {
                              setState(() => _value = selected ? e.key : null);
                              input['period'] += e.value;
                            },
                          ))
                    ])
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget projectDescription(TextEditingController _descriptionController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 30, top: 20, bottom: 13),
            child: Text('설명',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ))),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 100,
          child: TextFormField(
            onChanged: (_projectDescription) {
              setState(() {
                _saveDescription(_projectDescription);
              });
            },
            controller: _descriptionController,
            style: TextStyle(fontSize: 14, color: Colors.white),
            maxLines: 6,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white24,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: "프로젝트 설명란입니다.",
                hintStyle: TextStyle(fontSize: 14, color: Colors.white)),
            validator: (String value) {
              if (value.isEmpty) {
                return "프로젝트 설명을 입력하지 않았습니다.";
              }
              if (value.length > 10) {
                return "프로젝트 설명은 최소한 열 글자 이상이어야 합니다.";
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}
