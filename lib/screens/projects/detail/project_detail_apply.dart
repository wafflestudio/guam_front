import 'package:flutter/material.dart';
import 'package:guam_front/models/project.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_apply.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectDetailApply extends StatefulWidget {
  final Project project;
  final Projects projectProvider;

  ProjectDetailApply(this.project, this.projectProvider);

  @override
  _ProjectDetailApplyState createState() => _ProjectDetailApplyState();
}

class _ProjectDetailApplyState extends State<ProjectDetailApply> {
  String myPosition;
  List<String> positions = ['BACKEND', 'FRONTEND', 'DESIGNER'];
  final TextEditingController _introductionController = TextEditingController();

  @override
  void dispose() {
    _introductionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Future applyProject(int projectId, dynamic params) async {
      return await widget.projectProvider
          .applyProject(projectId, params)
          .then((successful) {
        if (successful) {
          Navigator.pop(context);
          widget.projectProvider.fetchProjects();
          return successful;
        }
      });
    }

    return Container(
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          children: [
            ProjectApply((idx) {
              setState(() {
                myPosition = positions[idx];
              });
            }),
            Padding(
              padding: EdgeInsets.only(bottom: 15, left: 5, right: 5),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                ),
                child: Theme(
                  data: ThemeData(
                      primaryColor: HexColor("#5A5A5A").withOpacity(0.8)),
                  child: TextField(
                    keyboardType: TextInputType.multiline,
                    controller: _introductionController,
                    minLines: 3,
                    maxLines: 10,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText:
                          "간단히 자기소개를 해주세요. 기술 스택, 개발 경험 등 자세하게 적어주시면 팀 구성에 도움이 된답니다.🚀",
                      hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                    ),
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ),
            _applyButton(size, applyProject)
          ],
        ));
  }

  Widget _applyButton(Size size, Function applyProject) {
    return Container(
      width: size.width * 0.85,
      child: RaisedButton(
          child: Text(
            '참여하기',
            style: TextStyle(
                fontSize: 16, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          color: HexColor("08951C"),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
          onPressed: () {
            final keyMap = {
              "introduction": _introductionController.text,
              "position": myPosition
            };
            applyProject(widget.project.id, keyMap);
          }),
    );
  }
}
