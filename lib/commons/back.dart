import 'package:flutter/material.dart';
import '../main.dart';

class Back extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: MyApp.themeColor,
      margin: EdgeInsets.zero,
      child: BackButton(color: Colors.white),
    );
  }
}
