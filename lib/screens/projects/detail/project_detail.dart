import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail_body.dart';
import '../../../commons/back.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../models/project.dart';
import '../../../commons/profile_thumbnail.dart';

class DetailProject extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;

  DetailProject(this.project, this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: "프로젝트",
          leading: Back(),
        ),
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
              image: AssetImage("assets/backgrounds/projects-bg.png"),
              fit: BoxFit.cover,
            )),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            child: SingleChildScrollView(
                child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: ProfileThumbnail(
                          radius: 12,
                          textColor: Colors.black,
                          profile: project.leader,
                          showNickname: true,
                        ),
                      ),
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: EdgeInsets.fromLTRB(5, 15, 0, 15),
                                alignment: Alignment.center,
                                child: Text(project.title,
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold
                                    )
                                )
                            ),
                            Container(
                                padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
                                child: Text(
                                    project.description ?? 'default description',
                                    style: TextStyle(fontSize: 14)
                                )
                            )
                          ]
                      ),
                      Container(
                          width: double.maxFinite,
                          child: ProjectDetailBody(project, projectsProvider))
                    ]))),
        ]));
  }
}
