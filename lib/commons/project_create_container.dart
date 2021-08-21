import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class ProjectCreateContainer extends StatelessWidget {
  final Widget content;

  ProjectCreateContainer({this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                HexColor("2B2939"),
                HexColor("6673AC"),
              ],
              begin: FractionalOffset(0.0, 1.0),
              end: FractionalOffset(0.0, 0.0),
              stops: [0, 1],
              tileMode: TileMode.clamp),
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
