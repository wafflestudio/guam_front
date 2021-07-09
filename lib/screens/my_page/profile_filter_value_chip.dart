import 'package:flutter/material.dart';
import 'package:guam_front/models/profile.dart';
import 'package:guam_front/providers/user_auth/authenticate.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class ProfileFilterValueChip extends StatefulWidget {
  final List<String> techStacks;
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
    widget.techStacks.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item,
              style: (selectedChoices.contains(item))
                  ? TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)
                  : TextStyle(fontSize: 12, color: Colors.black)),
          selected: selectedChoices.contains(item),
          selectedColor: HexColor("#08951C"),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
              widget.onSelectionChanged(selectedChoices);
            });
          },
        ),
      ));
    });

    return choices;
  }
}
