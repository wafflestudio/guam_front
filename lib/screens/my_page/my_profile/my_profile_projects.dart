import 'package:flutter/material.dart';
import '../../projects/project_square.dart';
import '../../../providers/user_auth/authenticate.dart';
import 'package:provider/provider.dart';

class MyProfileProjects extends StatelessWidget {
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
              children: [...context.read<Authenticate>().me.projects.map((e) =>
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
