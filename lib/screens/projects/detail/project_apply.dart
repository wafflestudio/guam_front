import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectApply extends StatefulWidget {
  final Function setMyPosition;

  ProjectApply(this.setMyPosition);

  @override
  _ProjectApplyState createState() => _ProjectApplyState();
}

class _ProjectApplyState extends State<ProjectApply> {
  Map<String, dynamic> pos = {
    'BACKEND': {
      'label': '백엔드',
      'selected': false,
    },
    'FRONTEND': {
      'label': '프론트엔드',
      'selected': false,
    },
    'DESIGNER': {
      'label': '디자이너',
      'selected': false,
    },
  };

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
          isSelected: [...pos.values.map((e) => e['selected'])],
          onPressed: (idx) {
            final pressedKey = pos.keys.toList()[idx];

            setState(() {
              for(int i = 0; i < pos.length; i++) {
                final key = pos.keys.toList()[i];
                if (key == pressedKey) pos[pressedKey]['selected'] = !pos[pressedKey]['selected']; // toggle pressed key
                else pos[key]['selected'] = false;
              }
            });

            final selected = pos.entries.firstWhere((entry) => entry.value['selected'] == true, orElse: () => MapEntry(null, null)); // returns null if no matching entry
            widget.setMyPosition(selected.key);
          },
          children: [...pos.values.map((e) => Padding(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              e['label'],
              style: TextStyle(
                  fontSize: 14,
                  color: e['selected'] ? Colors.white : HexColor("707070")
              ),
            )),
          )],
        ),
      ),
    );
  }
}
