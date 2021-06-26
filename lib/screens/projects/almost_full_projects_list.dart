import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/projects/projects.dart';
import 'sub_headings.dart';
import 'project_square.dart';

class AlmostFullProjectsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final projectsProvider = context.watch<Projects>();

    return Container(
      child: Column(
        children: [
          SubHeadings("⏰ 마감 임박"),
          Container(
            height: 150,
            padding: EdgeInsets.only(left: 10),
            child: projectsProvider.loading ?
            Center(child: CircularProgressIndicator()) :
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, int idx) => ProjectSquare(projectsProvider.almostFullProjects[idx]),
              itemCount: projectsProvider.almostFullProjects.length,
            )
          )
        ],
      ),
    );
  }
}
