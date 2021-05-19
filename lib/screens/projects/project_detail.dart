import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/project_apply.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../commons/app_bar.dart';
import '../../commons/back.dart';
import '../../models/project.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DetailProject extends StatelessWidget {
  final Project project;

  DetailProject(this.project);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(
        title: "프로젝트 신청하기",
        leading: Back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            height: 24,
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  child: Icon(Icons.person, color: Colors.white, size: 24),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.blue)],
                      shape: BoxShape.circle),
                ),
                Container(
                  width: 10,
                ),
                Text(
                  "waffle0112",
                  style: TextStyle(fontSize: 12, color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(5, 15, 0, 15),
              alignment: Alignment.centerLeft,
              child: Text(
                project.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          Container(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 30),
              alignment: Alignment.centerLeft,
              child: Text(
                project.description ?? 'default description',
                style: TextStyle(fontSize: 14),
              )),
          Container(
            height: 38,
            padding: EdgeInsets.fromLTRB(15, 0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Row(children: <Widget>[
              Icon(Icons.timer),
              Text(' 진행 기간    ',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
              Text(
                '${project.time}주',
                style: TextStyle(fontSize: 14),
              )
            ]),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            height: size.height * 0.25,
            padding: EdgeInsets.fromLTRB(15, 20, 0, 0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.people, size: 20),
                      Text(' 참여 현황 ',
                          style: TextStyle(
                              fontSize: 14, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _columnName("포지션"),
                            _text("백엔드"),
                            _text("프론트엔드"),
                            _text("디자니어"),
                          ],
                        ),
                        width: size.width * 0.2,
                        height: size.height * 0.2,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
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
                        width: size.width * 0.25,
                        height: size.height * 0.2,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _columnName("참가 인원"),
                            _percentBar(2, 4),
                            _percentBar(1, 3),
                            _percentBar(1, 1)
                          ],
                        ),
                        width: size.width * 0.2,
                        height: size.height * 0.2,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _columnName(""),
                            ProjectApply(),
                          ],
                        ),
                        width: size.width * 0.2,
                        height: size.height * 0.2,
                        padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      ),
                    ],
                  ),
                ]),
          ),
          SizedBox(height: size.height * 0.05),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLength: 100,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  "간단히 자기소개를 해주세요. 기술 스택, 개발 경험 등 자세하게 적어주시면 팀 구성에 도움이 된답니다.🚀",
              hintStyle: TextStyle(fontSize: 18, color: Colors.black38),
            ),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _applyButton(size)
        ]),
      ),
    );
  }

  Widget _text(String text) {
    return Container(
        padding: EdgeInsets.only(top: 17, bottom: 17),
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
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          color: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
      padding: EdgeInsets.only(top: 15, bottom: 13),
      child: LinearPercentIndicator(
        width: 60,
        animation: true,
        lineHeight: 20.0,
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
