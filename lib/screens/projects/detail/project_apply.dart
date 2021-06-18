import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectApply extends StatefulWidget {
  const ProjectApply({Key key}) : super(key: key);

  @override
  _ProjectApplyState createState() => _ProjectApplyState();
}

class _ProjectApplyState extends State<ProjectApply> {
  final isSelected = <bool>[false, false, false];
  final positions = <String>['백엔드', '프론트엔드', '디자이너'];

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      fillColor: HexColor("08951C"),
      borderColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      borderWidth: 0.3,
      constraints: BoxConstraints(minWidth: 125, minHeight: 36),
      isSelected: isSelected,
      onPressed: (idx) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == idx;
          }
        });
      },
      children: [
        // positions.map 으로 Padding Widget을 뿌려보려고 했는데 잘 안되네요..
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '백엔드',
            style: TextStyle(
                fontSize: 14,
                color: isSelected[0] ? Colors.white: HexColor("707070")),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '프론트엔드',
            style: TextStyle(
                fontSize: 14,
                color: isSelected[1] ? Colors.white: HexColor("707070")),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '디자이너',
            style: TextStyle(
                fontSize: 14,
                color: isSelected[2] ? Colors.white: HexColor("707070")),
          ),
        ),
      ],
    );
  }
}
