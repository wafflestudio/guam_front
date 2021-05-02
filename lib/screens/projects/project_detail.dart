import 'package:flutter/material.dart';
import '../../models/project.dart';

class DetailProject extends StatelessWidget {
  final Project project;
  DetailProject(this.project);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("프로젝트 신청하기")
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:8, horizontal: 12),
        child: Column(
          children: [
            Expanded(
                child: Text(
                    project.title ?? 'default title'
                )
            ),
            Expanded(
                child: Text(
                  project.description ?? 'default description'
                )
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLength: 100,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "간단 자기소개를 해주세요.",
              ),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ]
        ),
      ),
    );
  }
}
