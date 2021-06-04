import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/detail/project_detail_body.dart';
import '../../../commons/app_bar.dart';
import '../../../commons/back.dart';
import '../../../models/project.dart';

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
        body: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: EdgeInsets.only(left: 10, top: 10),
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
                  width: 5,
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
              alignment: Alignment.center,
              child: Text(
                project.title,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              )),
          Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 10),
              child: Text(
                project.description ?? 'default description',
                style: TextStyle(fontSize: 14),
              )),
          SizedBox(height: size.height * 0.03),
          Expanded(
            child: Align(
              alignment: FractionalOffset.bottomCenter,
              child: ProjectDetailBody(project)
            ),
          ),
        ]));
  }
}
