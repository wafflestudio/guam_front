import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:guam_front/models/profile.dart';
import 'package:guam_front/providers/user_auth/authenticate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ProfileFilterValueChip extends StatefulWidget {
  final List<dynamic> techStacks;
  // 추후 Function(List<int>)로 바꿔야 함.
  final Function(List<String>) onSelectionChanged;

  ProfileFilterValueChip(this.techStacks, this.onSelectionChanged);

  @override
  _ProfileFilterValueChipState createState() => _ProfileFilterValueChipState();
}

class _ProfileFilterValueChipState extends State<ProfileFilterValueChip> {
  List<String> selectedChoices = [];
  Profile me;

  @override
  void initState() {
    me = context.read<Authenticate>().me;
    // 추후 API response 변경되면 models/profile.dart에서 skills를
    // List<String>이 아니라 List<Map<int, String>>과 같은 형식으로 바꿔줘야 함.
    // 그래서 서버가 요청한대로 아래 List<int>를 request로 보낼 수 있도록.
    // selectedIds = List<int>.from(me.skills["id"]); <- 필요
    selectedChoices = List<String>.from(me.skills);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: _buildChoiceList(),
    );
  }

  _buildChoiceList() {
    List<Widget> choices = [];
    widget.techStacks.forEach((map) {
      var item = HashMap.from(map);
      // 화면 렌더링은 selectedChoices를 통해,
      // request는 selectedChoices와 매칭되는 selectedIds로 전송.
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item.values.single,
              style: (selectedChoices.contains(item.values.single))
                  ? TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  : TextStyle(fontSize: 12, color: Colors.black)),
          selected: selectedChoices.contains(item.values.single),
          selectedColor: HexColor("#08951C"),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item.values.single)
                  ? selectedChoices.remove(item.values.single)
                  : selectedChoices.add(item.values.single);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }
}
