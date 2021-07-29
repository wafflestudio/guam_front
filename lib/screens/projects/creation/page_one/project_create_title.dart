import 'package:flutter/material.dart';

class ProjectCreateTitle extends StatefulWidget {
  final Map input;

  ProjectCreateTitle(this.input);

  @override
  _ProjectCreateTitleState createState() => _ProjectCreateTitleState();
}

class _ProjectCreateTitleState extends State<ProjectCreateTitle> {
  final _projectNameController = TextEditingController();

  @override
  void dispose() {
    _projectNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 30, bottom: 15),
            child: Text('제목',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ))),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 50,
          child: TextFormField(
            onChanged: (text) => setState(() {
              widget.input["title"] = text;
            }),
            controller: _projectNameController,
            style: TextStyle(fontSize: 14, color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white24,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: "프로젝트 이름을 입력하세요.",
                hintStyle: TextStyle(fontSize: 14, color: Colors.white)),
            validator: (String value) {
              if (value.isEmpty) {
                return "프로젝트 이름을 입력하지 않았습니다.";
              }
              if (value.length > 2) {
                return "프로젝트 이름은 최소한 두 글자 이상이어야 합니다.";
              }
              return null;
            },
          ),
        )
      ],
    );
  }
}
