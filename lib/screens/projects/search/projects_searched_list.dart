import 'package:flutter/material.dart';
import '../project_banner.dart';
import '../sub_headings.dart';
import 'package:provider/provider.dart';
import '../../../providers/projects/projects.dart';

class ProjectsSearchedList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final List<String> tips = [
      "Tip : 키워드와 더불어 필터링을 활용해보세요.",
      "Tip : 원하는 기술 스택이 없다면 ETC를 선택해주세요.",
    ];
    tips.shuffle();

    Projects projectsProvider = context.watch<Projects>();

    return projectsProvider.loading ? CircularProgressIndicator() : Column(
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
                child: Text(tips.first, style: TextStyle(fontSize: 15)),
              ),
        )
      ],
    );
  }
}
