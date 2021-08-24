import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectCreateDue extends StatefulWidget {
  final Map input;
  final List<bool> dueSelected;
  final Function checkButtonEnable;

  ProjectCreateDue({this.input, this.dueSelected, this.checkButtonEnable});

  @override
  State createState() => _ProjectCreateDueState();
}

class _ProjectCreateDueState extends State<ProjectCreateDue> {
  void saveDue(idx) {
    setState(() {
      switch (idx) {
        case 0: widget.input["due"] = 'ONE'; break;
        case 1: widget.input["due"] = 'THREE'; break;
        case 2: widget.input["due"] = 'SIX'; break;
        case 3: widget.input["due"] = 'MORE'; break;
        default: widget.input["due"] = 'UNDEFINED'; break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.only(left: 25, bottom: 10),
            child: Text('진행 기간', style: TextStyle(fontSize: 18, color: Colors.white)),
          ),
          selectDue(),
        ],
      )
    );
  }

  Widget selectDue() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ToggleButtons(
          fillColor: HexColor("4694F9").withOpacity(0.5),
          borderColor: Colors.white,
          selectedBorderColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          borderWidth: 0.3,
          constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width * 0.85) / 4,
            minHeight: 40,
          ),
          isSelected: widget.dueSelected,
          onPressed: (idx) {
            setState(() {
              for (int i = 0; i < widget.dueSelected.length; i++) {
                widget.dueSelected[i] = i == idx;
              }
              widget.checkButtonEnable();
              saveDue(idx);
            });
          },
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('1개월 미만', style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('3개월 미만', style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('6개월 미만', style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text('6개월 이상', style: TextStyle(fontSize: 12, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}
