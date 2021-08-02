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
          child: projectsProvider.filteredProjects != null
            ? projectsProvider.filteredProjects.length != 0
              ? Column(
                  children: [
                    ...projectsProvider.filteredProjects
                      .map((e) => ProjectBanner(e, projectsProvider))
                  ],
                )
              : Padding(
                  padding: EdgeInsets.only(top: 50),
                  child: Text("검색 결과 없음"),
                )
            : Padding(
              padding: EdgeInsets.only(top: 50),
              child: Text(
                "Tip : 키워드와 더불어 필터링을 활용해보세요.",
                style: TextStyle(fontSize: 15),
              ),
            ),
        )
      ],
    );
  }
}
