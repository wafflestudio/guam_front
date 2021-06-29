import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/creation/project_create.dart';

class ProjectCreateButton extends StatelessWidget {
  final Projects projectProvider;

  ProjectCreateButton(this.projectProvider);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.add),
        color: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateProjectScreen(),
              ));
        });
  }
}
