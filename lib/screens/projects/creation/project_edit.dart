import 'package:flutter/material.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_page_one.dart';
import 'package:guam_front/screens/projects/creation/page_three/project_create_page_three.dart';
import 'package:guam_front/screens/projects/creation/page_two/project_create_page_two.dart';
import '../../../commons/back.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../models/project.dart';
import '../../../models/project.dart';
import '../../../models/stack.dart' as StackModel;
import '../../../providers/boards/boards.dart';

class ProjectEdit extends StatefulWidget {
  final Stacks stacksProvider;
  final Project projectInfo;

  ProjectEdit({this.stacksProvider, this.projectInfo});

  @override
  _ProjectEditState createState() => _ProjectEditState();
}

class _ProjectEditState extends State<ProjectEdit> {
  String selectedKey;
  List<String> filterValues;
  Map<String, List<StackModel.Stack>> _filterOptions = {
    'BACKEND': [],
    'FRONTEND': [],
    'DESIGNER': [],
  };
  List dueSelected = <bool>[false, false, false, false];
  final positionSelected = <bool>[false, false, false];
  int _currentPage = 1;
  Map input;

  getDueIdx(due) {
    int idx;
    switch (due) {
      case 'ONE': idx = 0; break;
      case 'THREE': idx = 1; break;
      case 'SIX': idx = 2; break;
      case 'MORE': idx = 3; break;
      default: idx = 4; break;
    }
    return idx;
  }

  void goToNextPage() => setState(() {_currentPage++;});
  void goToPreviousPage() => setState(() {_currentPage--;});

  @override
  void initState() {
    Project projectToBeEdited = widget.projectInfo;
    input = {
      'id': projectToBeEdited.id,
      'title': projectToBeEdited.title,
      'due': projectToBeEdited.due,
      'description': projectToBeEdited.description,

      // id 및 stack 순서는 server 수정 후 제대로 돌아갈 예정.

      'BACKEND': {
        'id': projectToBeEdited.techStacks[0].id,
        'stack': projectToBeEdited.techStacks[0].name,
        'headcount': projectToBeEdited.backHeadCount
      },
      'FRONTEND': {
        'id': projectToBeEdited.techStacks[1].id,
        'stack': projectToBeEdited.techStacks[1].name,
        'headcount': projectToBeEdited.frontHeadCount
      },
      'DESIGNER': {
        'id': projectToBeEdited.techStacks[2].id,
        'stack': projectToBeEdited.techStacks[2].name,
        'headcount': projectToBeEdited.designHeadCount
      },
      'thumbnail': projectToBeEdited.thumbnail,
      'isThumbnailChanged': false,
    };
    dueSelected[getDueIdx(widget.projectInfo.due)] = true;
    widget.stacksProvider.stacks.forEach((e) => _filterOptions[e.position].add(e));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(
          title: '프로젝트 수정하기',
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
                            input: input,
                            positionSelected: positionSelected,
                            goToPreviousPage: goToPreviousPage,
                            isNewProject: false,
                          ),
                        ProjectStatus(totalPage: 3, currentPage: _currentPage)
                      ])),
            )));
  }
}
