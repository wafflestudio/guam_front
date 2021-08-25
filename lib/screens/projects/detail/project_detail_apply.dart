import 'package:flutter/material.dart';
import 'package:guam_front/models/project.dart';
import 'package:provider/provider.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/screens/projects/detail/project_apply.dart';
import 'package:hexcolor/hexcolor.dart';
import 'apply_button.dart';

class ProjectDetailApply extends StatefulWidget {
  final Project project;

  ProjectDetailApply(this.project);

  @override
  _ProjectDetailApplyState createState() => _ProjectDetailApplyState();
}

class _ProjectDetailApplyState extends State<ProjectDetailApply> {
  final TextEditingController introController = TextEditingController();
  String myPosition;
  bool fieldsFulfilled;
  bool applying = false; // toggled true while requesting apply
  bool myPositionFilled() => myPosition != null && myPosition != "";
  bool introFilled() => introController.text != null && introController.text != "";

  @override
  void initState() {
    super.initState();
    fieldsFulfilled = false;
  }

  @override
  void dispose() {
    introController.dispose();
    super.dispose();
  }

  void setMyPosition(String position) {
    setState(() {
      myPosition = position;
    });
  }

  void checkFieldsFulfilled() {
    setState(() {
      fieldsFulfilled = myPositionFilled() && introFilled();
    });
  }

  void toggleApplying() {
    setState(() {
      applying = !applying;
    });
    print("applying: $applying");
  }

  @override
  Widget build(BuildContext context) {

    Future<void> applyProject({dynamic params}) async {
      toggleApplying();

      try {
        await context.read<Projects>().applyProject(
            projectId: widget.project.id,
            queryParams: {
              "introduction": introController.text,
              "position": myPosition,
            }
        ).then((successful) {
          if (successful) {
            introController.clear();
            setMyPosition(null);
            checkFieldsFulfilled();
            // Navigator.of(context).pop();
          }
        });
      } catch (e) {
        print(e);
      } finally {
        toggleApplying();
      }
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Column(
        children: [
          ProjectApply(setMyPosition),
          Padding(
            padding: EdgeInsets.all(15),
            child: Container(
              decoration: BoxDecoration(color: Colors.white),
              child: Theme(
                data: ThemeData(primaryColor: HexColor("#5A5A5A").withOpacity(0.8)),
                child: TextField(
                  keyboardType: TextInputType.multiline,
                  controller: introController,
                  minLines: 3,
                  maxLines: 10,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText:
                    "간단히 자기소개를 해주세요. 기술 스택, 개발 경험 등 자세하게 적어주시면 팀 구성에 도움이 된답니다.🚀",
                    hintStyle: TextStyle(fontSize: 14, color: Colors.black38),
                  ),
                  onChanged: (String _) {
                    checkFieldsFulfilled();
                  },
                ),
              ),
            ),
          ),
          applyButton(
            width: MediaQuery.of(context).size.width * 0.85,
            enabled: fieldsFulfilled,
            applying: applying,
            applyProject: applyProject,
          )
        ],
      )
    );
  }
}
