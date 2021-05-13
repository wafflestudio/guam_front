import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/projects/projects.dart';
import 'project_banner.dart';
import 'sub_headings.dart';

class ProjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectsProvider = context.read<Projects>();

    return Column(
      children: [
        SubHeadings("🖐 신규 프로젝트"),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [...projectsProvider.projects.map((e) => ProjectBanner(e))],
          ),
        ),
      ],
    );
  }
}
