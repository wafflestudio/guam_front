import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail_apply.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../../models/project.dart';

class ProjectDetailBody extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;

  ProjectDetailBody(this.project, this.projectsProvider);

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
          color: HexColor("#FFFFFF").withOpacity(0.8),
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
                Row(children: <Widget>[
                  Icon(Icons.timer),
                  Text(' 진행 기간     ',
                      style:
                          TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
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
                          project.techStacks != [] &&
                                  project.techStacks.length > 2
                              ? _text(project.techStacks[2].name.toString())
                              : Text(""),
                          project.techStacks != [] &&
                                  project.techStacks.length > 2
                              ? _text(project.techStacks[0].name.toString())
                              : Text(""),
                          project.techStacks != [] &&
                                  project.techStacks.length > 2
                              ? _text(project.techStacks[1].name.toString())
                              : Text(""),
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
                          _percentBar(
                              project.backHeadCount - project.backLeftCount,
                              project.backHeadCount),
                          _percentBar(
                              project.frontHeadCount - project.frontLeftCount,
                              project.frontHeadCount),
                          _percentBar(
                              project.designHeadCount - project.designLeftCount,
                              project.designHeadCount)
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
          ProjectDetailApply(project, projectsProvider),
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

  Widget _columnName(String attribute) {
    return Text("$attribute",
        style: TextStyle(
            color: HexColor("#828282"),
            fontSize: 14,
            fontWeight: FontWeight.bold));
  }

  Widget _percentBar(int currentCount, int totalCount) {
    return Padding(
      padding: EdgeInsets.only(top: 5, bottom: 3),
      child: LinearPercentIndicator(
        width: 79.6,
        animation: true,
        lineHeight: 25,
        animationDuration: 500,
        percent: totalCount == 0 ? 0 : currentCount / totalCount,
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
