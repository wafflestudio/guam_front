import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/project.dart';

class ProjectBanner extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;

  ProjectBanner(this.project, this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
        height: 150,
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
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          colorFilter:
                              ColorFilter.mode(Colors.white, BlendMode.dstATop),
                          image: AssetImage("assets/images/banner-glass.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Stack(
                              children: [
                                // 참가자 프로필
                                Positioned(
                                  child: Container(
                                    width: size.width * (1 - 0.2),
                                    child: Icon(Icons.monetization_on,
                                        size: 30, color: Colors.yellow),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    width: size.width * (1 - 0.3),
                                    child: Icon(Icons.monetization_on,
                                        size: 30, color: Colors.blue),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    width: size.width * (1 - 0.4),
                                    child: Icon(Icons.monetization_on,
                                        size: 30, color: Colors.green),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ))),
              Positioned.fill(
                  child: FractionallySizedBox(
                      widthFactor: 1,
                      heightFactor: 0.7,
                      alignment: FractionalOffset.bottomCenter,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: HexColor("#010101").withOpacity(0.4)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  project.title.length > 20
                                      ? project.title.substring(0, 18) + '...'
                                      : project.title,
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
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
