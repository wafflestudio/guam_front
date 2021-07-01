import 'package:flutter/material.dart';
import '../../../providers/projects/projects.dart';
import '../project_banner.dart';
import '../sub_headings.dart';

class ProjectsSearchedList extends StatelessWidget {
  final Projects projectsProvider;

  ProjectsSearchedList(this.projectsProvider);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SubHeadings("🔎 검색 결과"),
        Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: projectsProvider.loading
                ? Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      ...projectsProvider.projects.map((e) => ProjectBanner(e))
                    ],
                  )),
      ],
    );
  }
}
