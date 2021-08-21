import 'package:flutter/material.dart';

class ProjectCreateTitle extends StatefulWidget {
  final Map input;
  final Function checkButtonEnable;

  ProjectCreateTitle({this.input, this.checkButtonEnable});

  @override
  _ProjectCreateTitleState createState() => _ProjectCreateTitleState();
}

class _ProjectCreateTitleState extends State<ProjectCreateTitle> {
  final _projectNameController = TextEditingController();

  @override
  void initState() {
    _projectNameController.text = widget.input["title"];
    super.initState();
  }

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
          child: Text(
            '제목',
            style: TextStyle(fontSize: 18, color: Colors.white),
          )
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 70,
          child: TextFormField(
          maxLength: 20,
            onChanged: (text) {
              setState(() {widget.input["title"] = text;});
              widget.checkButtonEnable();
            },
            controller: _projectNameController,
            style: TextStyle(fontSize: 14, color: Colors.white),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white24,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.white),
              ),
              hintText: "프로젝트 이름을 입력하세요.",
              hintStyle: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}
