import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectCreateSave extends StatefulWidget {
  final Map input;
  final int page;
  final Stacks stacksProvider;
  final Projects projectProvider;

  ProjectCreateSave(
      {this.input, this.page, this.stacksProvider, this.projectProvider});

  @override
  _ProjectCreateSaveState createState() => _ProjectCreateSaveState();
}

class _ProjectCreateSaveState extends State<ProjectCreateSave> {
  setTechStackIdx(String techStack, String position) {
    setState(() {
      widget.stacksProvider.stacks.forEach((e) => {
            if (techStack == e.name) {widget.input[position]['id'] = e.id}
          });
    });
    switch (position) {
      case '백엔드':
        return "${widget.input[position]['id']}, BACKEND";
        break;
      case '프론트엔드':
        return "${widget.input[position]['id']}, FRONTEND";
        break;
      case '디자이너':
        return "${widget.input[position]['id']}, DESIGNER";
        break;
    }
  }

  Future createProject(dynamic body) async {
    return await widget.projectProvider
        .createProject(body)
        .then((successful) {
      if (successful) {
        Navigator.pop(context);
        widget.projectProvider.fetchProjects();
        return successful;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return (widget.page == 3
        ? Container(
            padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
            child: InkWell(
              onTap: () {
                final projectInfo = {
                  "title": widget.input['title'],
                  "due": widget.input['period'],
                  "description": widget.input['description'],
                  "backHeadCnt": widget.input['백엔드']['headcount'],
                  "designHeadCnt": widget.input['디자이너']['headcount'],
                  "frontHeadCnt": widget.input['프론트엔드']['headcount'],
                  "myPosition": widget.input['myPosition'],
                  "techStackIds": [
                    if (widget.input['백엔드']['stack'] != '')
                      setTechStackIdx(widget.input['백엔드']['stack'], '백엔드'),
                    if (widget.input['프론트엔드']['stack'] != '')
                      setTechStackIdx(widget.input['프론트엔드']['stack'], '프론트엔드'),
                    if (widget.input['디자이너']['stack'] != '')
                      setTechStackIdx(widget.input['디자이너']['stack'], '디자이너'),
                  ],
                  "imageFiles": null,
                };
                createProject(projectInfo);
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
                  gradient: LinearGradient(
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
