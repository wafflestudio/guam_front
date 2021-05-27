import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectCreateContainer extends StatelessWidget {
  final double height;
  final Widget content;

  ProjectCreateContainer({this.height, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.deepPurple,
          // 추후 그라데이션 넣을 예정
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Container(
          padding: EdgeInsets.all(6),
          child: content,
        ),
      ),
    );
  }
}
