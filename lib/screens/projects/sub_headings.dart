import 'package:flutter/material.dart';

class SubHeadings extends StatelessWidget {
  final String subheading;

  SubHeadings(this.subheading);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      padding: EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      alignment: Alignment.centerLeft,
      child: Text(
        subheading,
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
