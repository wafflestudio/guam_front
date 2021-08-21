import 'package:flutter/material.dart';
import '../../main.dart';

class ProjectsAppFloating extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.add),
      backgroundColor: MyApp.themeColor,
    );
  }
}
