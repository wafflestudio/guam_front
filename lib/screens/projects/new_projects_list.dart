import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/projects/new_projects.dart';
import 'new_project.dart';

class NewProjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newProjectsProvider = context.read<NewProjects>();

    return ListView.builder(
      itemBuilder: (context, int idx) => NewProject(newProjectsProvider.newProjects[idx]),
      itemCount: newProjectsProvider.newProjects.length,
    );
  }
}
