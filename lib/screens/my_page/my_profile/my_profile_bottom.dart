import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guam_front/models/profile.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:hexcolor/hexcolor.dart';

import 'my_profile_projects.dart';

class MyProfileBottom extends StatelessWidget {
  final Profile me;
  final Stacks stacksProvider;

  MyProfileBottom(this.me, this.stacksProvider);

  @override
  Widget build(BuildContext context) {
    Map techStacks = {
      'BACKEND': <String>[],
      'DESIGNER': <String>[],
      'FRONTEND': <String>[]
    };

    // shallow copying `techStacks`
    Map myStacks = json.decode(json.encode(techStacks));

    stacksProvider.stacks.forEach((e) => techStacks[e.position].add(e.name));

    me.skills.forEach((element) {
      techStacks.forEach((key, value) {
        if (techStacks[key].contains(element)) myStacks[key].add(element);
      });
    });
    myStacks['백엔드'] = myStacks.remove('BACKEND');
    myStacks['프론트엔드'] = myStacks.remove('FRONTEND');
    myStacks['디자이너'] = myStacks.remove('DESIGNER');

    final size = MediaQuery.of(context).size;

    return Container(
      width: double.maxFinite,
      child: Column(children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(30),
              topLeft: Radius.circular(30),
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _startBar("000000", 100, 5),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text('🛠 기술 스택     ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                ),
                ...myStacks.entries.map((e) => (e.value.length != 0)
                    ? Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 100,
                            padding: EdgeInsets.only(top: 15),
                            child: Text(e.key),
                          ),
                          Expanded(child: Wrap(spacing: 4, children: _buildChip(e.value))),
                        ],
                      )
                    : Container()),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('✋ 자기 소개 ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    if (me.introduction != null) Padding(
                      padding: EdgeInsets.only(right: 20),
                      child: Container(
                        width: size.width,
                        padding: EdgeInsets.fromLTRB(10, 10, 20, 10),
                        color: HexColor("#FFEB94"),
                        child: Text(me.introduction),
                      ),
                    )
                  ],
                ),
                MyProfileProjects()
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _startBar(String color, double width, double height) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: HexColor(color),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  List<Widget> _buildChip(List<dynamic> techStack) {
    return techStack
        .map<Widget>((i) => Chip(
              backgroundColor: HexColor("#E9E9E9"),
              side: BorderSide(color: HexColor("#979797"), width: 0.5),
              labelPadding: EdgeInsets.symmetric(horizontal: 2),
              label: Text(
                i,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.black,
                ),
              ),
            ))
        .toList();
  }
}
