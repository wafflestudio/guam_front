import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/projects/new_projects_list.dart';
import 'new_project.dart';

class NewProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final newProjectsListProvider = context.read<NewProjectsList>();

    return ListView.builder(
      itemBuilder: (context, int idx) => ChangeNotifierProvider.value(
        value: newProjectsListProvider.newProjects[idx],
        child: NewProject(),
      ),
      itemCount: newProjectsListProvider.newProjects.length,
    );
  }
}
