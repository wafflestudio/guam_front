import 'package:flutter/material.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateProjectBoard extends StatefulWidget {
  @override
  _CreateProjectBoardState createState() => _CreateProjectBoardState();
}

class _CreateProjectBoardState extends State<CreateProjectBoard> {
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final _periodOptions = {1: '주', 2: '월'};
  double _period = 1;
  Map result = {};

  @override
  void dispose() {
    _projectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 15),
        // child: GreyContainer(
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
                padding: EdgeInsets.only(top: 33, left: 30, bottom: 35),
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
              projectPeriod(_periodOptions),
              projectDescription(_projectDescriptionController),
              nextPage(),
              pageState(3, 1)
            ],
          ),
        ));
  }

  Widget projectTitle(TextEditingController _nameController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 30, bottom: 13),
            child: Text('제목',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ))),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 60,
          child: TextFormField(
            onChanged: (projectName) {
              print(projectName);
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

  Widget projectPeriod(Map _periodOptions) {
    return Container(
        padding: EdgeInsets.only(top: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 30, bottom: 13),
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
                          onChanged: (newPeriod) {
                            setState(() => _period = newPeriod);
                          }),
                    )),
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
                ChoiceChip(
                    selectedColor: HexColor('3EF7FF'),
                    label: Text(
                      '주',
                      style: TextStyle(fontSize: 14, color: Colors.black),
                    ),
                    selected: true),
                ChoiceChip(label: Text('월'), selected: true),
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
            onChanged: (projectName) {
              print(projectName);
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
                hintText: "프로젝트 설명란입니다. ",
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

  Widget nextPage() {
    return Container(
        padding: EdgeInsets.only(top: 60, bottom: 20),
        child: InkWell(
          onTap: () {
            print("asdf");
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.85,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '다음',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        ));
  }

  Widget pageState(num totalPage, num currentPage) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }
}
