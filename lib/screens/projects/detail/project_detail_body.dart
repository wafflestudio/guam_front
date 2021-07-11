import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/detail/project_apply.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../models/project.dart';

class ProjectDetailBody extends StatelessWidget {
  final Project project;

  ProjectDetailBody(this.project);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    _selectDue(String due) {
      switch (due) {
        case 'ONE':
          return '1개월 미만';
          break;
        case 'THREE':
          return '3개월 미만';
          break;
        case 'SIX':
          return '6개월 미만';
          break;
        case 'MORE':
          return '6개월 이상';
          break;
      }
    }

    return Column(children: [
      Container(
        decoration: BoxDecoration(
          color: HexColor("FEF2E4"),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                child: Column(
                  children: [
                    _startBar("08951C", 100, 5),
                    Row(children: <Widget>[
                      Icon(Icons.timer),
                      Text(' 진행 기간     ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(
                        '${_selectDue(project.due)}',
                        style: TextStyle(fontSize: 14),
                      )
                    ]),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 8, left: 2),
                      child: Row(
                        children: [
                          Icon(Icons.people, size: 20),
                          Text(' 참여 현황 ',
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _columnName("포지션"),
                              _text("백엔드"),
                              _text("프론트엔드"),
                              _text("디자이너"),
                            ],
                          ),
                          width: size.width * 0.35,
                          height: size.height * 0.2,
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _columnName("기술 스택"),
                              _text(project.techStacks[2].name.toString()),
                              _text(project.techStacks[0].name.toString()),
                              _text(project.techStacks[1].name.toString()),
                            ],
                          ),
                          width: size.width * 0.35,
                          height: size.height * 0.2,
                          padding: EdgeInsets.only(top: 10),
                        ),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _columnName("인원 현황"),
                              _percentBar(project.backHeadCount, 4),
                              _percentBar(project.frontHeadCount, 3),
                              _percentBar(project.designHeadCount, 1)
                            ],
                          ),
                          height: size.height * 0.2,
                          padding: EdgeInsets.only(top: 10),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Column(
                    children: [
                      ProjectApply(),
                      Padding(
                        padding: EdgeInsets.only(bottom: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: TextField(
                            keyboardType: TextInputType.multiline,
                            minLines: 3,
                            maxLines: 10,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText:
                                  "간단히 자기소개를 해주세요. 기술 스택, 개발 경험 등 자세하게 적어주시면 팀 구성에 도움이 된답니다.🚀",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.black38),
                            ),
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      _applyButton(size)
                    ],
                  )),
            ]),
      ),
    ]);
  }

  Widget _startBar(String color, double width, double height) {
    return Container(
      padding: EdgeInsets.only(bottom: 10),
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: HexColor(color),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _text(String text) {
    return Container(
        padding: EdgeInsets.only(top: 10, bottom: 10),
        child: Text(
          '$text',
          style: TextStyle(height: 1, fontSize: 14),
        ));
  }

  Widget _applyButton(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.05,
      child: RaisedButton(
          child: Text(
            '참여하기',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          color: HexColor("08951C"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {}),
    );
  }

  Widget _columnName(String attribute) {
    return Text("$attribute",
        style: TextStyle(
            color: HexColor("#828282"),
            fontSize: 14,
            fontWeight: FontWeight.bold));
  }

  Widget _percentBar(
    int currentCount,
    int totalCount,
  ) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 3),
      child: LinearPercentIndicator(
        width: 79.6,
        animation: true,
        lineHeight: 25,
        animationDuration: 500,
        percent: currentCount / totalCount,
        center: Container(
            padding: EdgeInsets.only(left: 37),
            alignment: Alignment.centerRight,
            child: Text("$totalCount",
                style: TextStyle(fontSize: 12, color: Colors.white))),
        backgroundColor: HexColor("#828282"),
        progressColor: HexColor("#8CE591"),
      ),
    );
  }
}
