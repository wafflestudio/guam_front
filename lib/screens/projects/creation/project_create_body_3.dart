import 'package:flutter/material.dart';
import 'package:guam_front/commons/app_bar.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';

class CreateProjectBoardThree extends StatefulWidget {
  const CreateProjectBoardThree({Key key}) : super(key: key);

  @override
  _CreateProjectBoardThreeState createState() =>
      _CreateProjectBoardThreeState();
}

class _CreateProjectBoardThreeState extends State<CreateProjectBoardThree> {
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
                    '3. 나의 포지션 선택',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 33, left: 30, bottom: 35),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '4. 프로젝트 사진 선택',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Back(),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.5,
                                      color: Colors.white24,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    '생성',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),
                ProjectStatus(totalPage: 3, currentPage: 3),
              ],
            ),
          )),
    );
  }
}
