import 'package:flutter/material.dart';
import '../../commons/app_bar.dart';
import '../../commons/back.dart';
import '../../models/project.dart';
import '../../main.dart';

class DetailProject extends StatelessWidget {
  final Project project;

  DetailProject(this.project);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: appBar(
        title: "프로젝트 신청하기",
        leading: Back(),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "2021/05/07",
            style: TextStyle(fontSize: 15, color: Colors.black45),
          ),
          Container(
            alignment: Alignment.centerLeft,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  child: Icon(Icons.person, color: Colors.white, size: 30),
                  decoration: BoxDecoration(
                      boxShadow: [BoxShadow(color: Colors.blue)],
                      shape: BoxShape.circle),
                ),
                Container(
                  width: 10,
                ),
                Text(
                  "waffle0112",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
          Container(
              padding: EdgeInsets.fromLTRB(5, 15, 0, 15),
              alignment: Alignment.centerLeft,
              child: Text(
                project.title,
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              )),
          Container(
              padding: EdgeInsets.fromLTRB(5, 20, 5, 30),
              alignment: Alignment.centerLeft,
              child: Text(
                project.description ?? 'default description',
                style: TextStyle(fontSize: 17),
              )),
          Container(
            height: size.height * 0.05,
            padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 5.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Row(children: <Widget>[
              Icon(Icons.timer),
              Text(' 진행 기간    ',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
              Text(
                '${project.time}주',
                style: TextStyle(fontSize: 17),
              )
            ]),
          ),
          SizedBox(height: size.height * 0.03),
          Container(
            height: size.height * 0.275,
            padding: EdgeInsets.fromLTRB(10, 10, 0, 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400],
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
                BoxShadow(
                  color: Colors.white,
                  blurRadius: 10.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    children: [
                      Icon(Icons.people),
                      Text(' 참여 현황 ',
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  DataTable(
                    columnSpacing: size.width * 0.05,
                    dividerThickness: 0,
                    columns: [
                      DataColumn(
                          label: Text('포지션',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('기술 스택',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(
                          label: Text('참가인원',
                              style: TextStyle(
                                  color: Colors.black54,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold))),
                      DataColumn(label: Text('')),
                    ],
                    rows: [
                      DataRow(cells: [
                        DataCell(Text('백엔드')),
                        DataCell(Text('${project.backFramework}')),
                        DataCell(Container(
                            alignment: Alignment.topRight,
                            width: size.width * 0.15,
                            height: size.height * 0.025,
                            padding: EdgeInsets.only(right: 6, top: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Text('${project.backHeadCount}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)))),
                        DataCell(Radio(
                          value: 1,
                          groupValue: 0,
                          onChanged: (_) {},
                        ))
                      ]),
                      DataRow(cells: [
                        DataCell(Text('프론트엔드')),
                        DataCell(Text('${project.frontFramework}')),
                        DataCell(Container(
                            alignment: Alignment.topRight,
                            width: size.width * 0.15,
                            height: size.height * 0.025,
                            padding: EdgeInsets.only(right: 6, top: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Text('${project.frontHeadCount}',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)))),
                        DataCell(Radio(
                          value: 0,
                          groupValue: 0,
                          onChanged: (_) {},
                        ))
                      ]),
                      DataRow(cells: [
                        DataCell(Text('디자이너')),
                        DataCell(Text('상관 없음')),
                        DataCell(Container(
                            alignment: Alignment.topRight,
                            width: size.width * 0.15,
                            height: size.height * 0.025,
                            padding: EdgeInsets.only(right: 6, top: 2),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            child: Text('1',
                                style: TextStyle(
                                    fontSize: 15, color: Colors.white)))),
                        DataCell(Radio(
                          value: 1,
                          groupValue: 0,
                          onChanged: (_) {},
                        ))
                      ]),
                    ],
                  ),
                ]),
          ),
          SizedBox(height: size.height * 0.05),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLength: 100,
            maxLines: 3,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText:
                  "간단히 자기소개를 해주세요. 기술 스택, 개발 경험 등 자세하게 적어주시면 팀 구성에 도움이 된답니다.🚀",
              hintStyle: TextStyle(fontSize: 18, color: Colors.black38),
            ),
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          _applyButton(size)
        ]),
      ),
    );
  }

  Widget _applyButton(Size size) {
    return Container(
      width: size.width,
      height: size.height * 0.05,
      child: RaisedButton(
          child: Text(
            '참여하기',
            style: TextStyle(fontSize: 20, color: Colors.white),
          ),
          color: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {}),
    );
  }
}
