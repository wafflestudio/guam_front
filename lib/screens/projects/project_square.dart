import 'package:flutter/material.dart';
import 'package:guam_front/commons/profile_thumbnail.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../helpers/http_request.dart';
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
                  image: project.thumbnail != null
                      ? NetworkImage(HttpRequest().s3BaseAuthority +
                          project.thumbnail.path)
                      : AssetImage("assets/images/project-square-default.jpeg"),
                  fit: BoxFit.fill,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
            )),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor("#787878").withOpacity(0.8),
                      HexColor("#000000").withOpacity(0.3)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
                  if (project.tasks.length < 4)
                    ...project.tasks.map(
                      (user) => project.tasks.indexOf(user) < 3
                        ? Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 20 * (project.tasks.indexOf(user).toDouble())),
                            child: ProfileThumbnail(
                              profile: user.user,
                              radius: 10,
                              showNickname: false,
                            ),
                          ),
                        )
                        : Positioned(
                            child: Padding(
                              padding: EdgeInsets.only(left: 40, top: 3),
                              child: Text(
                                "+${(project.tasks.length - 3).abs()}",
                                style: TextStyle(
                                  fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ),
                    ),
                ],
              ),
            ),
            Positioned.fill(
              top: 65,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Text(
                      project.title.length > 13
                          ? project.title.substring(0, 11) + '...'
                          : project.title,
                      style: TextStyle(
                        fontSize: 16,
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
      ),
    );
  }
}
