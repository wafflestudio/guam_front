import 'package:flutter/material.dart';
import 'package:guam_front/commons/next_page.dart';
import 'package:guam_front/commons/previous_page.dart';
import 'package:guam_front/screens/projects/creation/page_two/project_create_positions.dart';

class ProjectCreatePageTwo extends StatefulWidget {
  final Map input;
  final Map<dynamic, List<dynamic>> filterOptions;
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
  List<bool> isDataFilled = [true, true, true];

  @override
  void initState() {
    if (widget.input['백엔드']['stack'] == '') isDataFilled[0] = false;
    if (widget.input['프론트엔드']['stack'] == '') isDataFilled[1] = false;
    if (widget.input['디자이너']['stack'] == '') isDataFilled[2] = false;
    super.initState();
  }

  void checkDataFilled() {
    setState(() {
      if (widget.input['백엔드']['stack'] != '') isDataFilled[0] = true;
      if (widget.input['프론트엔드']['stack'] != '') isDataFilled[1] = true;
      if (widget.input['디자이너']['stack'] != '') isDataFilled[2] = true;
    });
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
        ProjectCreatePositions(
            widget.input, widget.filterOptions, isDataFilled, checkDataFilled),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            PreviousPage(page: 2, onTap: widget.goToPreviousPage),
            NextPage(
              page: 2,
              onTap: widget.goToNextPage,
              active: isDataFilled,
            ),
          ],
        )
      ],
    );
  }
}
