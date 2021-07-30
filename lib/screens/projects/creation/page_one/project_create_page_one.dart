import 'package:flutter/material.dart';
import 'package:guam_front/commons/next_page.dart';
import 'project_create_description.dart';
import 'project_create_due.dart';
import 'project_create_title.dart';

class ProjectCreatePageOne extends StatefulWidget {
  final Map input;
  final List<bool> dueSelected;
  final Function goToNextPage;

  ProjectCreatePageOne(
    this.input,
    this.dueSelected,
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
        && widget.input['due'] != null;
    super.initState();
  }

  void checkButtonEnable() => setState(() {
    nextBtnEnabled = widget.input['title'] != ''
        && widget.input['description'] != ''
        && widget.input['due'] != null;
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
          ProjectCreateTitle(input: widget.input, checkButtonEnable: checkButtonEnable),
          ProjectCreateDue(input: widget.input, dueSelected: widget.dueSelected, checkButtonEnable: checkButtonEnable),
          ProjectCreateDescription(input: widget.input, checkButtonEnable: checkButtonEnable),
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
