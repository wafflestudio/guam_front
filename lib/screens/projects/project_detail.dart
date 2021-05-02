import 'package:flutter/material.dart';
import '../../models/project.dart';
import 'package:guam_front/main.dart';

class DetailProject extends StatelessWidget {
  final Project project;
  DetailProject(this.project);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text("프로젝트 신청하기")
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical:8, horizontal: 12),
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.center,
                child: Text(
                  project.title ?? 'default title',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                )
            ),
            Container(
                padding: EdgeInsets.all(20),
                alignment: Alignment.centerLeft,
                child: Text(
                  project.description ?? 'default description',
                  style: TextStyle(fontSize: 20),
                )
            ),
            Divider(
                color: Colors.black
            ),
            SizedBox(
                height: size.height*0.03
            ),
            Row(
              children: <Widget>[
                Icon(Icons.timer),
                Text(
                  ' 진행 기간   ',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold)
                  ),
                Text(
                  '${project.time}주',
                  style: TextStyle(fontSize: 20),
                )
              ]
            ),
            SizedBox(
                height: size.height*0.03
            ),
            Row(
                children: <Widget>[
                  Icon(Icons.people),
                  Text(
                      ' 구성           ',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold)
                  ),
                  Text(
                    '백엔드 ${project.backHeadCount}명 (${project.backFramework})\n'
                        '클라이언트 ${project.frontHeadCount}명 (${project.frontFramework})',
                    style: TextStyle(fontSize: 20),
                  )
                ]
            ),
            SizedBox(
                height: size.height*0.05
            ),
            SizedBox(
                height: size.height*0.03
            ),
            TextField(
              keyboardType: TextInputType.multiline,
              maxLength: 100,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: "간단히 자기소개를 해주세요.",
              ),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 40
            ),
            _authButton(size)
          ]
        ),
      ),
    );
  }

  Widget _authButton(Size size){
    return Container(
      width: size.width*0.5,
      height: size.height*0.05,
      child: RaisedButton(
          child: Text(
              '참여하기',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          color: MyApp.themeColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)),
          onPressed: (){
          }),
    );
  }
}
