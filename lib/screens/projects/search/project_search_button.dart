import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/search/project_search.dart';

class ProjectSearchButton extends StatelessWidget {
  final Stacks stacksProvider;
  final Projects projectsProvider;

  ProjectSearchButton(this.stacksProvider, this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      color: Colors.black,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SearchScreen(stacksProvider, projectsProvider)));
      },
    );
  }
}
