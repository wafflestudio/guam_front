import 'package:flutter/material.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_page_one.dart';
import 'package:guam_front/screens/projects/creation/page_three/project_create_page_three.dart';
import 'package:guam_front/screens/projects/creation/page_two/project_create_page_two.dart';
import '../../../commons/back.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../models/stack.dart' as StackModel;

class ProjectCreate extends StatefulWidget {
  final Stacks stacksProvider;

  ProjectCreate({this.stacksProvider});

  @override
  _ProjectCreateState createState() => _ProjectCreateState();
}

class _ProjectCreateState extends State<ProjectCreate> {
  String selectedKey;
  List<String> filterValues;

  Map input = {
    'title': '',
    'due': null,
    'description': '',
    'BACKEND': {'id': 0, 'stack': '', 'headcount': 0},
    'FRONTEND': {'id': 0, 'stack': '', 'headcount': 0},
    'DESIGNER': {'id': 0, 'stack': '', 'headcount': 0},
    'myPosition': '',
    'thumbnail': null,
  };

  Map<String, List<StackModel.Stack>> _filterOptions = {
    'BACKEND': [],
    'FRONTEND': [],
    'DESIGNER': [],
  };

  final dueSelected = <bool>[false, false, false, false];
  final positionSelected = <bool>[false, false, false];

  int _currentPage = 1;

  @override
  void initState() {
    widget.stacksProvider.stacks.forEach((e) => _filterOptions[e.position].add(e));
    super.initState();
  }

  void goToNextPage() => setState(() {_currentPage++;});
  void goToPreviousPage() => setState(() {_currentPage--;});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '프로젝트 만들기',
          leading: Back(),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 5),
            child: ProjectCreateContainer(
              content: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    if (_currentPage == 1)
                      ProjectCreatePageOne(
                          input,
                          dueSelected,
                          goToNextPage),
                    if (_currentPage == 2)
                      ProjectCreatePageTwo(input, _filterOptions, goToNextPage, goToPreviousPage),
                    if (_currentPage == 3)
                      ProjectCreatePageThree(
                          input,
                          positionSelected,
                          goToPreviousPage,
                      ),
                    ProjectStatus(totalPage: 3, currentPage: _currentPage)
                  ])),
            )));
  }
}
