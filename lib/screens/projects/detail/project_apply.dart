import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectApply extends StatefulWidget {
  final Function onSelectionChanged;

  ProjectApply(this.onSelectionChanged);

  @override
  _ProjectApplyState createState() => _ProjectApplyState();
}

class _ProjectApplyState extends State<ProjectApply> {
  final isSelected = <bool>[false, false, false];
  final positions = <String>['백엔드', '프론트엔드', '디자이너'];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Container(
        decoration: BoxDecoration(
            color: HexColor("F3EEE9"),
            borderRadius: BorderRadius.all(Radius.circular(10))),
        child: ToggleButtons(
          fillColor: HexColor("08951C"),
          borderColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          borderWidth: 0.3,
          constraints: BoxConstraints(
              minWidth:
                  MediaQuery.of(context).size.width * 0.85 / positions.length,
              minHeight: 36),
          isSelected: isSelected,
          onPressed: (idx) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == idx;
              }
              widget.onSelectionChanged(idx);
            });
          },
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '백엔드',
                style: TextStyle(
                    fontSize: 14,
                    color: isSelected[0] ? Colors.white : HexColor("707070")),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '프론트엔드',
                style: TextStyle(
                    fontSize: 14,
                    color: isSelected[1] ? Colors.white : HexColor("707070")),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '디자이너',
                style: TextStyle(
                    fontSize: 14,
                    color: isSelected[2] ? Colors.white : HexColor("707070")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
