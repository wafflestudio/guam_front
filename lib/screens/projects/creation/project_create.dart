import 'package:flutter/material.dart';
import 'package:guam_front/screens/projects/creation/project_create_body.dart';
import '../../../commons/app_bar.dart';
import '../../../commons/back.dart';

class CreateProjectScreen extends StatefulWidget {
  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBar(
          title: '프로젝트 만들기',
          leading: Back(),
        ),
        body: CreateProjectBoard());
  }
}
