import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail_body.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../commons/back.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../models/project.dart';

class DetailProject extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;

  DetailProject(this.project, this.projectsProvider);

  @override
  Widget build(BuildContext context) {

    print(project.id);
    print(project.leader);
    print(project.frontLeftCount);
    print(project.isRecruiting);
    print(project.techStacks);
    return Scaffold(
        appBar: CustomAppBar(
          title: "프로젝트",
          leading: Back(),
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      HexColor("#FFFFFF").withOpacity(0.8),
                      HexColor("#FEF2E4"),
                      HexColor("#D5D7DE"),
                    ],
                    begin: FractionalOffset(0.0, 0.4),
                    end: FractionalOffset(0.0, 0.0),
                    stops: [0, 0.5, 1],
                    tileMode: TileMode.clamp)),
          ),
          Container(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                  child: Column(children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Container(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: Row(children: [
                        Container(
                            child: project.leader.imageUrl != null
                                ? CircleAvatar(
                                    radius: 12,
                                    backgroundImage:
                                        NetworkImage(project.leader.imageUrl),
                                    backgroundColor: Colors.transparent,
                                  )
                                : Icon(Icons.person,
                                    color: Colors.white, size: 24),
                            decoration: BoxDecoration(
                                boxShadow: [BoxShadow(color: Colors.blue)],
                                shape: BoxShape.circle)),
                        Text(project.leader.nickname,
                            style: TextStyle(fontSize: 12, color: Colors.black))
                      ])),
                  Container(
                      padding: EdgeInsets.fromLTRB(5, 15, 0, 15),
                      alignment: Alignment.center,
                      child: Text(project.title,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold))),
                  Container(
                      padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
                      child: Text(project.description ?? 'default description',
                          style: TextStyle(fontSize: 14)))
                ]),
                Container(
                    width: double.maxFinite,
                    child: ProjectDetailBody(project, projectsProvider))
              ]))),
        ]));
  }
}
