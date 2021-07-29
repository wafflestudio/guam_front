import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectCreatePeriod extends StatefulWidget {
  final Map input;
  final List<bool> periodSelected;

  ProjectCreatePeriod(this.input, this.periodSelected);

  @override
  _ProjectCreatePeriodState createState() => _ProjectCreatePeriodState();
}

class _ProjectCreatePeriodState extends State<ProjectCreatePeriod> {
  void savePeriod(idx) {
    setState(() {
      switch (idx) {
        case 0:
          widget.input["period"] = 'ONE';
          break;
        case 1:
          widget.input["period"] = 'THREE';
          break;
        case 2:
          widget.input["period"] = 'SIX';
          break;
        case 3:
          widget.input["period"] = 'MORE';
          break;
        default:
          widget.input["period"] = 'UNDEFINED';
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.input);

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
