import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail_apply.dart';
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
        case 'ONE': return '1개월 미만'; break;
        case 'THREE': return '3개월 미만'; break;
        case 'SIX': return '6개월 미만'; break;
        case 'MORE': return '6개월 이상'; break;
      }
    }

    _selectTechStack(List techStacks, String position) {
      String techStack;
      project.techStacks.forEach((e) {
        if (position == e.position){
          techStack = e.name;
        }
      });
      return techStack;
    }

    return Column(children: [
      Container(
        padding: EdgeInsets.only(bottom: 100),
        decoration: BoxDecoration(
          color: HexColor("#FFFFFF").withOpacity(0.65),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(30),
            topLeft: Radius.circular(30),
          ),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
            child: Column(
              children: [
                _startBar("08951C", 100, 5),
                Row(
                  children: <Widget>[
                    Icon(Icons.timer),
                    Text(
                      ' 진행 기간     ',
                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                    ),
                    Text('${_selectDue(project.due)}', style: TextStyle(fontSize: 14))
                  ]
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10, bottom: 8, left: 2),
                  child: Row(
                    children: [
                      Icon(Icons.people, size: 20),
                      Text(
                        ' 참여 현황 ',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)
                      ),
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
                      width: size.width * 0.3,
                      padding: EdgeInsets.only(top: 10),
                    ),
                    Container(
                      width: size.width * 0.3,
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _columnName("기술 스택"),
                          project.techStacks != [] && project.techStacks.length > 2
                            ? _text(_selectTechStack(project.techStacks, 'BACKEND'))
                            : Text(""),
                          project.techStacks != [] && project.techStacks.length > 2
                            ? _text(_selectTechStack(project.techStacks, 'FRONTEND'))
                            : Text(""),
                          project.techStacks != [] && project.techStacks.length > 2
                            ? _text(_selectTechStack(project.techStacks, 'DESIGNER'))
                            : Text(""),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 5),
                            child: _columnName("인원 현황"),
                          ),
                          _percentBar(
                            size: size,
                            currentCnt: project.backHeadCount - project.backLeftCount,
                            totalCnt: project.backHeadCount,
                          ),
                          _percentBar(
                            size: size,
                            currentCnt: project.frontHeadCount - project.frontLeftCount,
                            totalCnt: project.frontHeadCount,
                          ),
                          _percentBar(
                            size: size,
                            currentCnt: project.designHeadCount - project.designLeftCount,
                            totalCnt: project.designHeadCount,
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          ProjectDetailApply(project),
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
      )
    );
  }

  Widget _columnName(String attribute) {
    return Text(
      "$attribute",
      style: TextStyle(
        color: HexColor("#828282"),
        fontSize: 14,
        fontWeight: FontWeight.bold,
      )
    );
  }

  Widget _percentBar({Size size, int currentCnt, int totalCnt}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6),
      child: LinearPercentIndicator(
        width: size.width * 0.25,
        animation: true,
        lineHeight: 20,
        animationDuration: 500,
        percent: totalCnt == 0 ? 0 : currentCnt / totalCnt,
        backgroundColor: HexColor("#828282"),
        progressColor: HexColor("#8CE591"),
        center: Container(
          padding: EdgeInsets.only(left: 37),
          alignment: Alignment.centerRight,
          child: Text(
            "$totalCnt",
            style: TextStyle(fontSize: 12, color: Colors.white),
          )
        ),
      ),
    );
  }
}
