import 'package:flutter/material.dart';
import 'package:guam_front/commons/app_bar.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/commons/next_page.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:guam_front/screens/projects/creation/project_create_body_3.dart';
import 'package:guam_front/screens/projects/creation/project_create_filter.dart';
import 'package:hexcolor/hexcolor.dart';

class CreateProjectBoardTwo extends StatefulWidget {
  final Map _periodOptions = {1: '주', 2: '월'};

  @override
  _CreateProjectBoardTwoState createState() => _CreateProjectBoardTwoState();
}

class _CreateProjectBoardTwoState extends State<CreateProjectBoardTwo> {
  Map _input = {'title': '', 'period': '', 'description': ''};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: '프로젝트 만들기',
        leading: Back(),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 15),
          child: ProjectCreateContainer(
            content: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 33, left: 30, bottom: 35),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '2. 인원 및 스택 구성',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(3,10,10,10),
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                      border: Border.all(color: HexColor("979797")),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TechStackFilter(),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Back(),
                    NextPage(
                      nextPage: CreateProjectBoardThree(),
                      text: '다음',
                      buttonWidth: MediaQuery.of(context).size.width * 0.45,
                    ),
                  ],
                ),
                ProjectStatus(totalPage: 3, currentPage: 2)
              ],
            ),
          )),
    );
  }
}
