import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectApply extends StatelessWidget {
  final String myPosition;
  final Function setMyPosition;
  final Map<String, dynamic> pos = {
    'BACKEND': {
      'label': '백엔드',
    },
    'FRONTEND': {
      'label': '프론트엔드',
    },
    'DESIGNER': {
      'label': '디자이너',
    },
  };

  ProjectApply({this.myPosition, this.setMyPosition});

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
              minWidth: MediaQuery.of(context).size.width * 0.85 / pos.length,
              minHeight: 36
          ),
          isSelected: [...pos.keys.map((e) => e == myPosition)],
          onPressed: (idx) {
            final String pressedKey = pos.keys.toList()[idx];
            if (myPosition == pressedKey) {
              setMyPosition(null);
            } else {
              setMyPosition(pressedKey);
            }
          },
          children: [...pos.entries.map((e) => Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                e.value['label'],
                style: TextStyle(
                    fontSize: 14,
                    color: e.key == myPosition ? Colors.white : HexColor("707070")
                ),
              )),
          )],
        ),
      ),
    );
  }
}
