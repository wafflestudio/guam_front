import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectApply extends StatefulWidget {
  const ProjectApply({Key key}) : super(key: key);

  @override
  _ProjectApplyState createState() => _ProjectApplyState();
}

class _ProjectApplyState extends State<ProjectApply> {
  var _result;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _radioCheckButton("백엔드"),
        _radioCheckButton("프론트엔드"),
        _radioCheckButton("디자이너"),
      ],
    );
  }

  Widget _radioCheckButton(selectedPosition) {
    return Container(
      padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
      child: Radio(
        fillColor: MaterialStateProperty.all<Color>(HexColor("#08951C")),
        value: selectedPosition,
        groupValue: _result,
        onChanged: (value) {
          setState(() {
            _result = value;
          });
        },
      ),
    );
  }
}
