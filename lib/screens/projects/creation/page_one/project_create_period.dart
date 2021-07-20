import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectCreatePeriod extends StatefulWidget {
  final Map input;
  final List<bool> periodSelected;
  final Function onChanged;

  ProjectCreatePeriod(this.input, this.periodSelected,
      {@required this.onChanged});

  @override
  _ProjectCreatePeriodState createState() => _ProjectCreatePeriodState();
}

class _ProjectCreatePeriodState extends State<ProjectCreatePeriod> {
  void savePeriod(idx) {
    setState(() {
      widget.input["period"] = idx;
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
                child: Text('진행 기간',
                    style: TextStyle(fontSize: 18, color: Colors.white))),
            _selectPeriod()
          ],
        ));
  }

  Widget _selectPeriod() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ToggleButtons(
        fillColor: HexColor("4694F9").withOpacity(0.5),
        borderColor: Colors.white,
        selectedBorderColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        borderWidth: 0.3,
        constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width * 0.85) / 4,
            minHeight: 40),
        isSelected: widget.periodSelected,
        onPressed: (idx) {
          setState(() {
            for (int i = 0; i < widget.periodSelected.length; i++) {
              widget.periodSelected[i] = i == idx;
            }
            widget.onChanged();
            savePeriod(idx);
          });
        },
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '1개월 미만',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '3개월 미만',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '6개월 미만',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              '6개월 이상',
              style: TextStyle(fontSize: 12, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
