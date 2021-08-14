import 'package:flutter/material.dart';

class ProjectCreateDescription extends StatefulWidget {
  final Map input;
  final Function checkButtonEnable;

  ProjectCreateDescription({this.input, this.checkButtonEnable});

  @override
  _ProjectCreateDescriptionState createState() => _ProjectCreateDescriptionState();
}

class _ProjectCreateDescriptionState extends State<ProjectCreateDescription> {
  final TextEditingController _descriptionController = TextEditingController();

  @override
  void initState() {
    _descriptionController.text = widget.input["description"];
    super.initState();
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 30, top: 20, bottom: 13),
          child: Text('설명',
            style: TextStyle(fontSize: 18, color: Colors.white)
          )
        ),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 140,
          child: TextFormField(
            maxLength: 250,
            onChanged: (text) {
              setState(() => widget.input["description"] = text);
              widget.checkButtonEnable();
            },
            controller: _descriptionController,
            style: TextStyle(fontSize: 14, color: Colors.white),
            maxLines: 6,
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
              hintText: "프로젝트 설명란입니다.",
              hintStyle: TextStyle(fontSize: 14, color: Colors.white)
            ),
          ),
        )
      ],
    );
  }
}
