import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectSquare extends StatelessWidget {
  final Project project;

  ProjectSquare(this.project);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      width: 180,
      margin: EdgeInsets.only(right: 3),
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
                    colors: [HexColor("#787878").withOpacity(0.75), HexColor("#000000").withOpacity(0.75)],
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
    );
  }
}
