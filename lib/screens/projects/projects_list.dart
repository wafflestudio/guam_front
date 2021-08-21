import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/projects/projects.dart';
import 'project_banner.dart';
import 'sub_headings.dart';

class ProjectsList extends StatelessWidget {
  final Projects projectsProvider;

  ProjectsList(this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    final projectsProvider = context.watch<Projects>();

    return Column(
      children: [
        SubHeadings("🖐 신규 프로젝트"),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: projectsProvider.loading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      ...projectsProvider.projects
                          .map((e) => ProjectBanner(e, projectsProvider))
                    ],
                  )),
      ],
    );
  }
}
