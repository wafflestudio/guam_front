import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/detail/project_detail.dart';
import '../../models/project.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectSquare extends StatelessWidget {
  final Project project;

  ProjectSquare(this.project);

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
                    borderRadius: BorderRadius.circular(5)
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
      )
    );
  }
}
