import 'package:flutter/material.dart';
import 'package:guam_front/commons/next_page.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_description.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_period.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_title.dart';

class ProjectCreatePageOne extends StatefulWidget {
  final Map input;
  final List<bool> periodSelected;
  final TextEditingController _projectNameController;
  final TextEditingController _projectDescriptionController;

  ProjectCreatePageOne(
    this.input,
    this.periodSelected,
    this._projectNameController,
    this._projectDescriptionController,
  );

  @override
  _ProjectCreatePageOneState createState() => _ProjectCreatePageOneState();
}

class _ProjectCreatePageOneState extends State<ProjectCreatePageOne> {
  bool isTitleFilled = false;

  void _checkElementFilled(bool e) {
    setState(() {
      isTitleFilled = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(isTitleFilled);
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
          ProjectCreateTitle(widget.input, widget._projectNameController,
              onChanged: () {
            _checkElementFilled(isTitleFilled);
          }),
          ProjectCreatePeriod(widget.input, widget.periodSelected),
          ProjectCreateDescription(
              widget.input, widget._projectDescriptionController),
          // NextPage(page: 1)
        ],
      ),
    );
  }
}
