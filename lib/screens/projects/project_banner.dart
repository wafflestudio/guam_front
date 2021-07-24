import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';

import '../../models/project.dart';

class ProjectBanner extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;

  ProjectBanner(this.project, this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 160,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
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
                  child: DecoratedBox(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/banner-glass.png"),
                    fit: BoxFit.fill,
                  ),
                ),
              )),
              Positioned.fill(
                  child: FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: 0.7,
                      alignment: FractionalOffset.bottomCenter,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.25)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  project.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w500,
                                  ),
                                )
                              ],
                            ),
                          )))),
            ],
          ),
        ));
  }
}
