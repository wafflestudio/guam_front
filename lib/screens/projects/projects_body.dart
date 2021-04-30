import 'package:flutter/material.dart';
import 'new_projects_list.dart';

class ProjectsBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double bodyHeight = MediaQuery.of(context).size.height -
        Scaffold.of(context).appBarMaxHeight -
        kBottomNavigationBarHeight;

    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            child: Text('필터'),
          ),
          Container(
            height: bodyHeight * 0.2,
          ),
          Container(
            height: bodyHeight * 0.8,
            child: NewProjectsList(),
          )
        ],
      ),
    );
  }
}
