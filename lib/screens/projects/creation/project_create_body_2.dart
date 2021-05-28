import 'package:flutter/material.dart';
import 'package:guam_front/commons/app_bar.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/commons/next_page.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:guam_front/screens/projects/creation/project_create_body_3.dart';
import 'package:guam_front/screens/projects/creation/project_create_filter.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateProjectBoardTwo extends StatefulWidget {
  final Map _periodOptions = {1: '주', 2: '월'};

  @override
  _CreateProjectBoardTwoState createState() => _CreateProjectBoardTwoState();
}

class _CreateProjectBoardTwoState extends State<CreateProjectBoardTwo> {
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  int _value = 1;
  double _period = 1;
  Map _input = {'title': '', 'period': '', 'description': ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: '프로젝트 만들기',
        leading: Back(),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 15),
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
                    '2. 인원 및 스택 구성',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                TechStackFilter(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Back(),
                    NextPage(
                      nextPage: CreateProjectBoardThree(),
                      text: '다음',
                      buttonWidth: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ],
                ),
                ProjectStatus(totalPage: 3, currentPage: 2)
              ],
            ),
          )),
    );
  }

  Widget projectPeriod() {
    print(_period);
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
                            _input['period'] = _period.toString();
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
                Wrap(children: [
                  ...widget._periodOptions.entries.map((e) => FilterChip(
                    label: Text(
                      '${e.value}',
                      style: TextStyle(fontSize: 14, color: Colors.white),
                    ),
                    showCheckmark: false,
                    side: BorderSide(color: Colors.white, width: 0.5),
                    padding:
                    EdgeInsets.symmetric(horizontal: 2, vertical: 1),
                    selected: _value == e.key,
                    selectedColor: HexColor('993EF7FF'),
                    onSelected: (bool selected) {
                      setState(() => _value = selected ? e.key : null);
                      _input['period'] += e.value;
                    },
                  ))
                ])
              ],
            )
          ],
        ));
  }
}
