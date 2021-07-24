import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:guam_front/models/profile.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/my_page/my_profile/my_projects.dart';
import 'package:hexcolor/hexcolor.dart';

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
                if (myStacks['백엔드'].length != 0)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100,
                        padding: EdgeInsets.only(top: 15),
                        child: Text("백엔드"),
                      ),
                      Expanded(
                        child: _wrap(myStacks['백엔드']),
                      ),
                    ],
                  ),
                if (myStacks['프론트엔드'].length != 0)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100,
                        padding: EdgeInsets.only(top: 15),
                        child: Text("프론트엔드"),
                      ),
                      Expanded(
                        child: _wrap(myStacks['프론트엔드']),
                      ),
                    ],
                  ),
                if (myStacks['디자이너'].length != 0)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: 100,
                        padding: EdgeInsets.only(top: 15),
                        child: Text("디자이너"),
                      ),
                      Expanded(
                        child: _wrap(myStacks['디자이너']),
                      ),
                    ],
                  ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Text('✋ 자기 소개 ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold)),
                    ),
                    Padding(
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
                MyProjects()
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _wrap(List techStack) {
    return Wrap(
        spacing: 4,
        children: techStack.map((e) {
          return _buildChip(e);
        }));
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

  Widget _buildChip(String label) {
    return Chip(
      backgroundColor: HexColor("#E9E9E9"),
      side: BorderSide(color: HexColor("#979797"), width: 0.5),
      labelPadding: EdgeInsets.symmetric(horizontal: 2),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }
}
