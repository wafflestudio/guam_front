import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/project.dart';

class ProjectSquare extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;

  ProjectSquare(this.project, this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: 150,
        margin: EdgeInsets.only(right: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        DetailProject(project, projectsProvider)));
          },
          child: Stack(
            children: [
              Positioned.fill(
                  child: Container(
                decoration: BoxDecoration(
                    image: DecorationImage(
                      // Temp code. Should use cached_network_image with errorWidget (default image) and placeholder
                      image: project.thumbnail != ""
                          ? NetworkImage(project.thumbnail)
                          : AssetImage(
                              "assets/images/project-square-default.jpeg"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(5)),
              )),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        HexColor("#787878").withOpacity(0.4),
                        HexColor("#000000").withOpacity(0.4)
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  padding: EdgeInsets.all(20),
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    children: [
                      Text(
                        project.title,
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
