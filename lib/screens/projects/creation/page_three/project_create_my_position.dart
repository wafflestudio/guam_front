import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectCreateMyPosition extends StatefulWidget {
  final Map input;
  final List<bool> positionSelected;

  ProjectCreateMyPosition(this.input, this.positionSelected);

  @override
  _ProjectCreateMyPositionState createState() =>
      _ProjectCreateMyPositionState();
}

class _ProjectCreateMyPositionState extends State<ProjectCreateMyPosition> {
  void saveMyPosition(idx) {
    setState(() {
      widget.input["myPosition"] = ['BACKEND', 'FRONTEND', 'DESIGNER'][idx];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ToggleButtons(
        fillColor: HexColor("4694F9").withOpacity(0.5),
        borderColor: Colors.white,
        selectedBorderColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        borderWidth: 0.3,
        constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width * 0.85) / 3,
            minHeight: 40),
        isSelected: widget.positionSelected,
        onPressed: (idx) {
          setState(() {
            for (int i = 0; i < widget.positionSelected.length; i++) {
              widget.positionSelected[i] = i == idx;
            }
            saveMyPosition(idx);
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '백엔드',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '프론트엔드',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '디자이너',
              style: TextStyle(fontSize: 14, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
