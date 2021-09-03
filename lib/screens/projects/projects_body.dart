import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';

import 'almost_full_projects_list.dart';
import 'projects_list.dart';

class ProjectsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AlmostFullProjectsList(),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          ProjectsList(),
        ],
      ),
    );
  }
}
