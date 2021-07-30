import 'package:flutter/material.dart';
import 'package:guam_front/commons/next_page.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_description.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_period.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_title.dart';

class ProjectCreatePageOne extends StatefulWidget {
  final Map input;
  final List<bool> periodSelected;
  final Function goToNextPage;

  ProjectCreatePageOne(
    this.input,
    this.periodSelected,
    this.goToNextPage,
  );

  @override
  State<StatefulWidget> createState() => ProjectCreatePageOneState();
}

class ProjectCreatePageOneState extends State<ProjectCreatePageOne> {
  bool nextBtnEnabled;

  @override
  void initState() {
    nextBtnEnabled = widget.input['title'] != ''
        && widget.input['description'] != ''
        && widget.input['period'] != null;
    super.initState();
  }

  void checkButtonEnable() => setState(() {
    nextBtnEnabled = widget.input['title'] != ''
        && widget.input['description'] != ''
        && widget.input['period'] != null;
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            child: Container(
              width: 100,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
            alignment: Alignment.centerLeft,
            child: Text(
              '1. 프로젝트 아웃라인',
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          ProjectCreateTitle(widget.input),
          ProjectCreatePeriod(widget.input, widget.periodSelected),
          ProjectCreateDescription(widget.input),
          NextPage(
            page: 1,
            onTap: widget.goToNextPage,
            active: nextBtnEnabled,
          )
        ],
      ),
    );
  }
}
