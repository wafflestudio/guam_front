import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class GreyContainer extends StatelessWidget {
  final double height;
  final Widget content;

  GreyContainer({this.height, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: HexColor('#EBEBEB'),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 14,
            vertical: 6,
          ),
          child: content,
        ),
      ),
    );
  }
}
