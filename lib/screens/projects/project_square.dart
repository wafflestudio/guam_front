import 'package:flutter/material.dart';
import 'package:guam_front/commons/profile_thumbnail.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../helpers/http_request.dart';
import '../../models/project.dart';

class ProjectSquare extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;
  final bool allowOnTap;

  ProjectSquare({this.project, this.projectsProvider, allowOnTap})
      : this.allowOnTap = allowOnTap ?? true;

  @override
  Widget build(BuildContext context) {
    final int maxProfileCnt = 3;

    return Container(
      height: 150,
      width: 150,
      margin: EdgeInsets.only(right: 10),
      child: InkWell(
        onTap: () {
          if (allowOnTap) Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => ChangeNotifierProvider.value(
                value: context.read<Projects>(),
                child: ProjectDetail(project),
            ))
          );
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                  // Temp code. Should use cached_network_image with errorWidget (default image) and placeholder
                    image: project.thumbnail != null && project.thumbnail.path != null
                      ? NetworkImage(HttpRequest().s3BaseAuthority +
                          project.thumbnail.path)
                      : AssetImage("assets/images/project-square-default.jpeg"),
                  fit: BoxFit.fill,
                ),
                  borderRadius: BorderRadius.circular(30),
                ),
              )
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      HexColor("#787878").withOpacity(0.8),
                      HexColor("#000000").withOpacity(0.2)
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
            ),
            if (project.tasks != null) Container(
              padding: EdgeInsets.all(10),
              alignment: Alignment.topLeft,
              child: Stack(
                children: [
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
                            ),
                          ),
                        )
                      : Positioned(
                          child: Padding(
                            padding: EdgeInsets.only(left: 20.0 * maxProfileCnt, top: 3),
                            child: Text(
                              "+${(project.tasks.length - maxProfileCnt)}",
                              style: TextStyle(fontSize: 12, color: Colors.white),
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: 60,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  project.title,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
