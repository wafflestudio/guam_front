import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../models/project.dart';

class ProjectBanner extends StatelessWidget {
  final Project project;

  ProjectBanner(this.project);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 150,
        width: double.infinity,
        margin: EdgeInsets.only(bottom: 10),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => DetailProject(project)));
          },
          child: Stack(
            children: [
              Positioned.fill(
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.white.withOpacity(0.8), BlendMode.dstATop),
                          image: AssetImage("assets/images/banner-glass.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                // User Profile Image를 역순으로 배치 (width : 40*n + 30)
                                Positioned(
                                  child: Container(
                                    width: 110,
                                    child: Icon(Icons.monetization_on,
                                        size: 30, color: Colors.yellow),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    width: 70,
                                    child: Icon(Icons.monetization_on,
                                        size: 30, color: Colors.blue),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    width: 30,
                                    child: Icon(Icons.monetization_on,
                                        size: 30, color: Colors.green),
                                  ),
                                ),
                              ],
                            )
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
                              color: HexColor("#010101").withOpacity(0.3)),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
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
                          )))),
              // Positioned.fill(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       image: DecorationImage(
              //         image: NetworkImage(project.thumbnail),
              //         fit: BoxFit.fill,
              //       ),
              //     ),
              //   )
              // ),
              // Positioned.fill(
              //   child: Container(
              //     decoration: BoxDecoration(
              //       gradient: LinearGradient(
              //         colors: [HexColor("#787878").withOpacity(0.4), HexColor("#000000").withOpacity(0.4)],
              //         begin: Alignment.topCenter,
              //         end: Alignment.bottomCenter,
              //       )
              //     ),
              //   ),
              // ),
            ],
          ),
        ));
  }
}
