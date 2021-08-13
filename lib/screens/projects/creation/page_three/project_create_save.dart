import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:provider/provider.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../providers/boards/boards.dart';

class ProjectCreateSave extends StatefulWidget {
  final Map input;
  final int page;
  final bool btnEnabled;
  final bool isNewProject;

  ProjectCreateSave({this.input, this.page, this.btnEnabled, this.isNewProject});

  @override
  _ProjectCreateSaveState createState() => _ProjectCreateSaveState();
}

class _ProjectCreateSaveState extends State<ProjectCreateSave> {
  Future createOrUpdateProject({dynamic files}) async {
    Map<String, String> fields = {
      "title": widget.input['title'],
      "due": widget.input['due'],
      "description": widget.input['description'],
      "backHeadCnt": widget.input['BACKEND']['headcount'].toString(),
      "designHeadCnt": widget.input['DESIGNER']['headcount'].toString(),
      "frontHeadCnt": widget.input['FRONTEND']['headcount'].toString(),
      "frontStackId": widget.input['FRONTEND']['id'].toString(),
      "backStackId": widget.input['BACKEND']['id'].toString(),
      "designStackId": widget.input['DESIGNER']['id'].toString(),
      "myPosition": widget.input['myPosition'].toString(),
    };
    if (widget.isNewProject) {
      return await context.read<Projects>().createProject(
        fields: fields,
        files: files,
      ).then((successful) {
        if (successful) {
          Navigator.pop(context);
          context.read<Projects>().fetchProjects();
          return successful;
        }
      });
    } else {
      return await context.read<Boards>().editProject(
        projectId: widget.input['id'],
        fields: fields,
        files: files,
      ).then((successful) {
        if (successful) {
          Navigator.pop(context); // project edit 페이지 나가
          context.read<Boards>().fetchBoard(widget.input['id']);
          return successful;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return (
      widget.page == 3
      ? Container(
          padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
          child: InkWell(
            onTap: () async {
              if (widget.btnEnabled)
                await createOrUpdateProject(
                  files: (widget.input['thumbnail'] != null) && widget.input['isThumbnailChanged']
                      ? [File(widget.input["thumbnail"].path)]
                      : null
                ).then((value) {
                  Navigator.of(context).pop(); // pops board_setting modal
                });
            },
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.45,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(width: 1.5, color: Colors.white24),
                borderRadius: BorderRadius.circular(30),
                gradient: !widget.btnEnabled
                  ? null
                  : LinearGradient(
                      colors: [HexColor("4F34F3"), HexColor("3EF7FF")],
                      begin: FractionalOffset(1.0, 0.0),
                      end: FractionalOffset(0.0, 0.0),
                      stops: [0, 1],
                      tileMode: TileMode.clamp,
                    ),
              ),
              child: Text(
                '${widget.isNewProject ? '생성' : '수정'}',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        )
      : Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.45,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(width: 1.5, color: Colors.white24),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '${widget.isNewProject ? '생성' : '수정'}',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )
      )
    );
  }
}
