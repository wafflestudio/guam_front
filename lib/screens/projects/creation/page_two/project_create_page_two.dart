import 'package:flutter/material.dart';
import 'package:guam_front/commons/next_page.dart';
import 'package:guam_front/commons/previous_page.dart';
import 'package:guam_front/models/stack.dart' as StackModel;
import 'package:guam_front/screens/projects/creation/page_two/project_create_positions.dart';

class ProjectCreatePageTwo extends StatefulWidget {
  final Map input;
  final Map<String, List<StackModel.Stack>> filterOptions;
  final Function goToNextPage;
  final Function goToPreviousPage;

  ProjectCreatePageTwo(
    this.input,
    this.filterOptions,
    this.goToNextPage,
    this.goToPreviousPage,
  );

  @override
  _ProjectCreatePageTwoState createState() => _ProjectCreatePageTwoState();
}

class _ProjectCreatePageTwoState extends State<ProjectCreatePageTwo> {
  bool nextBtnEnabled;

  void checkButtonEnable() => setState(() {
    nextBtnEnabled = widget.input['title'] != ''
        && widget.input['description'] != ''
        && widget.input['period'] != null;
  });

  @override
  void initState() {
    nextBtnEnabled = widget.input['title'] != ''
        && widget.input['description'] != ''
        && widget.input['period'] != null;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
            '2. 인원 및 스택 구성',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ProjectCreatePositions(input: widget.input, filterOptions: widget.filterOptions), //
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PreviousPage(page: 2, onTap: widget.goToPreviousPage),
            NextPage(
              page: 2,
              onTap: widget.goToNextPage,
              active: nextBtnEnabled,
            ),
          ],
        )
      ],
    );
  }
}
