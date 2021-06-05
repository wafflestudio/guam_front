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
                    SizedBox(height: size.height * 0.015),
                    Row(children: <Widget>[
                      Icon(Icons.timer),
                      Text(' 진행 기간     ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                      Text(
                        '${project.time}주',
                        style: TextStyle(fontSize: 14),
                      )
                    ]),
                    SizedBox(height: size.height * 0.015),
                    Row(
                      children: [
                        Icon(Icons.people, size: 20),
                        Text(' 참여 현황 ',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold)),
                      ],
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
                              _text(project.backFramework),
                              _text(project.frontFramework),
                              _text("상관 없음"),
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
                              _percentBar(2, 4),
                              _percentBar(1, 3),
                              _percentBar(1, 1)
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
                decoration: BoxDecoration(
                  color: HexColor("FFF9F2"),
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  ),
                ),
                child: Container(
                    height: size.height * 0.3,
                    padding: EdgeInsets.fromLTRB(15, 5, 15, 0),
                    child: Column(
                      children: [
                        _startBar("08951C", 100, 5),
                        SizedBox(height: size.height * 0.015),
                        Container(
                          decoration: BoxDecoration(
                            color: HexColor("F3EEE9"),
                            borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          child: ProjectApply(),
                        ),
                        SizedBox(height: size.height * 0.02),
                        Container(
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
                        SizedBox(height: size.height * 0.02),
                        _applyButton(size)
                      ],
                    )),
              ),
            ]),
      ),
    ]);
  }

  Widget _startBar(String color, double width, double height) {
    return Container(
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
