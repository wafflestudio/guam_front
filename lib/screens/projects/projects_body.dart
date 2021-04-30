import 'package:flutter/material.dart';
import 'projects_list.dart';
import 'almost_full_projects_list.dart';

class ProjectsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          AlmostFullProjectsList(),
          ProjectsList(),
        ],
      ),
    );
  }
}
