import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../helpers/http_request.dart';
import '../../models/project.dart';

class ProjectSquare extends StatelessWidget {
  final Project project;
  final Projects projectsProvider;

  ProjectSquare(this.project, this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    project.tasks.forEach((e) {
      print(HttpRequest().s3BaseAuthority + e.user.imageUrl);
    });
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
                          : AssetImage(
                              "assets/images/project-square-default.jpeg"),
                      fit: BoxFit.fill,
                    ),
                    borderRadius: BorderRadius.circular(30)),
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
                    Stack(children: [
                      ...project.tasks.map((user) => Container(
                          height: 20,
                          width: 20,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey,
                          ),
                          child: ClipOval(
                            child: user.user.imageUrl != null
                                ? FadeInImage(
                                    placeholder: MemoryImage(kTransparentImage),
                                    image: NetworkImage(
                                        HttpRequest().s3BaseAuthority +
                                            user.user.imageUrl),
                                    fit: BoxFit.cover,
                                  )
                                : Icon(
                                    Icons.person,
                                    size: 20,
                                  ),
                          )))
                    ]),
                    //   Positioned(
                    //   child: Container(
                    //     width: 20,
                    //     child: Icon(Icons.monetization_on,
                    //         size: 20, color: Colors.yellow),
                    //   ),
                    // ),
                    //   Positioned(
                    //     child: Container(
                    //       width: 50,
                    //       child: Icon(Icons.monetization_on,
                    //           size: 20, color: Colors.blue),
                    //     ),
                    //   ),
                    //   Positioned(
                    //     child: Container(
                    //       width: 80,
                    //       child: Icon(Icons.monetization_on,
                    //           size: 20, color: Colors.green),
                    //     ),
                    //   ),
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
