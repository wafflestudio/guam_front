import 'package:flutter/material.dart';

class ProjectCreateSelectedPositions extends StatelessWidget {
  final Map input;

  ProjectCreateSelectedPositions(this.input);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Container(
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _selectedPositions(_position),
              _selectedPositions(_techStack),
              _selectedPositions(_headCnt),
            ],
          ),
        ),
      ],
    );
  }

  Widget _selectedPositions(Widget element(String position)){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [...['BACKEND', 'FRONTEND', 'DESIGNER'].map((e) => element(e))],
    );
  }

  setPosition(String positionEng) {
    String positionKor;
    switch (positionEng) {
      case 'BACKEND': positionKor = '백엔드'; break;
      case 'FRONTEND': positionKor = '프론트엔드'; break;
      case 'DESIGNER': positionKor = '디자이너'; break;
    }
    return positionKor;
  }

  Widget _position(String position) {
    return (input[position]["stack"].toString() != '')
      ? Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            setPosition(position),
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
      : Container();
  }

  Widget _techStack(String position) {
    return (input[position]["stack"].toString() != '')
      ? Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            input[position]["stack"],
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
      : Container();
  }

  Widget _headCnt(String position) {
    return (input[position]["stack"].toString() != '')
      ? Padding(
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            input[position]["headcount"].toString(),
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        )
      : Container();
  }
}
