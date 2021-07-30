import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import '../../../../models/stack.dart' as StackModel;
import 'package:hexcolor/hexcolor.dart';

class ProjectCreateSave extends StatefulWidget {
  final Map input;
  final int page;
  final Projects projectProvider;
  final bool btnEnabled;

  ProjectCreateSave({this.input, this.page, this.projectProvider, this.btnEnabled});

  @override
  _ProjectCreateSaveState createState() => _ProjectCreateSaveState();
}

class _ProjectCreateSaveState extends State<ProjectCreateSave> {
  Future createProject({Map<String, dynamic> fields, dynamic files}) async {
    return await widget.projectProvider
      .createProject(
        fields: fields,
        files: files,
    ).then((successful) {
      if (successful) {
        Navigator.pop(context);
        widget.projectProvider.fetchProjects();
        return successful;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final projectInfo = {
      "title": widget.input['title'],
      "due": widget.input['period'],
      "description": widget.input['description'],
      "backHeadCnt": widget.input['BACKEND']['headcount'],
      "designHeadCnt": widget.input['DESIGNER']['headcount'],
      "frontHeadCnt": widget.input['FRONTEND']['headcount'],
      "myPosition": widget.input['myPosition'],
      // "techStackIds": [
      //   if (widget.input['BACKEND']['stack'] != '')
      //     setTechStackIdx(widget.input['BACKEND']['stack'], '백엔드'),
      //   if (widget.input['FRONTEND']['stack'] != '')
      //     setTechStackIdx(widget.input['프론트엔드']['stack'], '프론트엔드'),
      //   if (widget.input['DESIGNER']['stack'] != '')
      //     setTechStackIdx(widget.input['디자이너']['stack'], '디자이너'),
      // ],
    };

    return (
        widget.page == 3
        ? Container(
            padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
            child: InkWell(
              onTap: () {
                if (widget.btnEnabled) createProject(
                    fields: projectInfo,
                    files: widget.input['thumbnail'] != null ? [File(widget.input['thumbnail'].path)] : null
                );
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.45,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white24,
                  ),
                  gradient: !widget.btnEnabled
                      ? null
                      : LinearGradient(
                      colors: [
                        HexColor("4F34F3"),
                        HexColor("3EF7FF"),
                      ],
                      begin: FractionalOffset(1.0, 0.0),
                      end: FractionalOffset(0.0, 0.0),
                      stops: [0, 1],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '생성',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
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
                border: Border.all(
                  width: 1.5,
                  color: Colors.white24,
                ),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '생성',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )));
  }
}
