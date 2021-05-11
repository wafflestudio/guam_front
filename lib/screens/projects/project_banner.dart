import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/project_detail.dart';
import '../../models/project.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectBanner extends StatelessWidget {
  final Project project;

  ProjectBanner(this.project);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailProject(project))
          );
        },
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(project.thumbnail),
                    fit: BoxFit.fill,
                  ),
                ),
              )
            ),
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [HexColor("#787878").withOpacity(0.4), HexColor("#000000").withOpacity(0.4)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
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
      )
    );
  }
}
