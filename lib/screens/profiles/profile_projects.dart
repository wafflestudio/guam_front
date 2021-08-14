import 'package:flutter/material.dart';
import 'package:guam_front/models/profile.dart';
import '../projects/project_square.dart';

class ProfileProjects extends StatelessWidget {
  final Profile me;

  ProfileProjects(this.me);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text(
              '📋 참여한 프로젝트 ',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
              )
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [...me.projects.map((e) =>
                ProjectSquare(
                  project: e,
                  allowOnTap: false,
                )
              )]
            ),
          )
        ],
      ),
    );
  }
}
