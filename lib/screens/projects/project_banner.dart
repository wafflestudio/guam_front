import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:guam_front/commons/profile_thumbnail.dart';
import 'package:guam_front/commons/techStack_thumbnail.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../helpers/http_request.dart';
import '../../models/project.dart';

class ProjectBanner extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;

  ProjectBanner(this.project, this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    final int maxProfileCnt = 3;

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
                      if (project.techStacks.length > 0)
                        Stack(children: [
                          ...project.techStacks.map(
                            (techStack) => Positioned(
                              child: Padding(
                                padding: EdgeInsets.only(left: 30 * (project.techStacks.indexOf(techStack).toDouble())),
                                child: TechStackThumbnail(techStack: techStack, radius: 12),
                              ),
                            ),
                          )
                        ]),
                      Spacer(),
                      Stack(children: [
                        ...project.tasks.map(
                          (user) => project.tasks.indexOf(user) < maxProfileCnt
                              ? Positioned(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      left: 20 * (project.tasks.indexOf(user).toDouble())),
                                    child: ProfileThumbnail(
                                      profile: user.user,
                                      radius: 10,
                                      showNickname: false,
                                      activateRedirectOnTap: false,
                                      activateChangeTask: false,
                                    ),
                                  ),
                                )
                              : Positioned(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 60, top: 3),
                                    child: Text(
                                      " +${(project.tasks.length - maxProfileCnt)}",
                                      style: TextStyle(fontSize: 12, color: Colors.black),
                                    ),
                                  ),
                                ),
                        )
                      ])
                    ],
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: FractionallySizedBox(
                widthFactor: 1,
                heightFactor: 0.7,
                alignment: FractionalOffset.bottomCenter,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: project.thumbnail != null
                        ? NetworkImage(HttpRequest().s3BaseAuthority + project.thumbnail.path)
                        : AssetImage("assets/images/project-thumbnail-default.png"),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.5), BlendMode.dstATop),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                    color: HexColor("#010101").withOpacity(0.4),
                  ),
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
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
