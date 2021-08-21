import 'package:flutter/material.dart';
import 'package:guam_front/commons/previous_page.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/creation/page_three/project_create_my_position.dart';
import 'package:guam_front/screens/projects/creation/page_three/project_create_save.dart';
import 'package:guam_front/screens/projects/creation/page_three/project_create_thumbnail.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectCreatePageThree extends StatefulWidget {
  final Map input;
  final List<bool> positionSelected;
  final Function goToPreviousPage;
  final bool isNewProject;

  ProjectCreatePageThree({
    this.input,
    this.positionSelected,
    this.goToPreviousPage,
    this.isNewProject
  });

  @override
  _ProjectCreatePageThreeState createState() => _ProjectCreatePageThreeState();
}

class _ProjectCreatePageThreeState extends State<ProjectCreatePageThree> {
  bool nextBtnEnabled;

  void checkButtonEnable() => setState(() {
    nextBtnEnabled = widget.input['myPosition'] != '';
  });

  @override
  void initState() {
    nextBtnEnabled = widget.input['myPosition'] != '';
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
        if (widget.isNewProject)
        Container(
          padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            '3. 나의 포지션 선택',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        if (widget.isNewProject)
        Container(
          decoration: BoxDecoration(
            color: HexColor("6B70AA"),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ProjectCreateMyPosition(
            input: widget.input,
            positionSelected: widget.positionSelected,
            checkButtonEnable: checkButtonEnable,
          ),
        ),
        Container(
          padding: EdgeInsets.only(top: 40, left: 30, bottom: 10),
          alignment: Alignment.centerLeft,
          child: Text(
            '${widget.isNewProject ? 4 : 3}. 프로젝트 사진 선택',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        ProjectCreateThumbnail(widget.input, widget.isNewProject),
        Theme(
          data: Theme.of(context).copyWith(
            unselectedWidgetColor: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PreviousPage(page: 2, onTap: widget.goToPreviousPage),
              ProjectCreateSave(
                input: widget.input,
                page: 3,
                btnEnabled: widget.isNewProject ? nextBtnEnabled : true,
                isNewProject: widget.isNewProject,
              )
            ],
          ),
        ),
      ],
    );
  }
}
