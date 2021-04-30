import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'package:hexcolor/hexcolor.dart';

class NewProject extends StatelessWidget {
  final Project newProject;

  NewProject(this.newProject);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(newProject.thumbnail),
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
                    newProject.title,
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
