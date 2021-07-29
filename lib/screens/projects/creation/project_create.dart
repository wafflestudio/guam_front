import 'package:flutter/material.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_page_one.dart';
import 'package:guam_front/screens/projects/creation/page_three/project_create_page_three.dart';
import 'package:guam_front/screens/projects/creation/page_two/project_create_page_two.dart';

import '../../../commons/back.dart';
import '../../../commons/custom_app_bar.dart';

class CreateProjectScreen extends StatefulWidget {
  final Projects projectProvider;
  final Stacks stacksProvider;

  CreateProjectScreen(this.projectProvider, this.stacksProvider);

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  String selectedKey;
  List<String> filterValues;
  Map input = {
    'title': '',
    'period': 'UNDEFINED',
    'description': '',
    '백엔드': {'id': 0, 'stack': '', 'headcount': 0},
    '프론트엔드': {'id': 0, 'stack': '', 'headcount': 0},
    '디자이너': {'id': 0, 'stack': '', 'headcount': 0},
    'myPosition': '',
  };
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final periodSelected = <bool>[false, false, false, false];
  final positionSelected = <bool>[false, false, false];
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    var _filterOptions = {
      'BACKEND': <String>[],
      'DESIGNER': <String>[],
      'FRONTEND': <String>[]
    };

    widget.stacksProvider.stacks
        .forEach((e) => _filterOptions[e.position].add(e.name));

    _filterOptions['백엔드'] = _filterOptions.remove('BACKEND');
    _filterOptions['프론트엔드'] = _filterOptions.remove('FRONTEND');
    _filterOptions['디자이너'] = _filterOptions.remove('DESIGNER');

    void goToNextPage() {
      setState(() {
        _currentPage++;
      });
    }

    void goToPreviousPage() {
      setState(() {
        _currentPage--;
      });
    }

    print(input);
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
                          periodSelected,
                          _projectNameController,
                          _projectDescriptionController,
                          goToNextPage),
                    if (_currentPage == 2)
                      ProjectCreatePageTwo(input, _filterOptions, goToNextPage,
                          goToPreviousPage),
                    if (_currentPage == 3)
                      ProjectCreatePageThree(
                          input, positionSelected, goToPreviousPage),
                    ProjectStatus(totalPage: 3, currentPage: _currentPage)
                  ])),
            )));
  }

  setTechStackIdx(String techStack, String position) {
    setState(() {
      widget.stacksProvider.stacks.forEach((e) => {
            if (techStack == e.name) {input[position]['id'] = e.id}
          });
    });
    return input[position]['id'];
  }
}
