import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class SavePage extends StatefulWidget {
  final int page;
  final Function onTap;

  SavePage({@required this.page, @required this.onTap});

  @override
  _SavePageState createState() => _SavePageState();
}

class _SavePageState extends State<SavePage> {
  @override
  Widget build(BuildContext context) {
    return (widget.page == 3
        // && input['myPosition'] != ''
        ? Container(
            padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
            child: InkWell(
              onTap: () {
                // final projectInfo = {
                //   "title": input['title'],
                //   "due": input['period'],
                //   "description": input['description'],
                //   "backLeftCnt": input['백엔드']['headcount'],
                //   "designLeftCnt": input['디자이너']['headcount'],
                //   "frontLeftCnt": input['프론트엔드']['headcount'],
                //   "myPosition": input['myPosition'],
                //   "thumbnail": input['thumbnail'],
                //   "techStackIds": [
                //     {
                //       "first": setTechStackIdx(input['백엔드']['stack'], '백엔드'),
                //       "second": "BACKEND"
                //     },
                //     {
                //       "first":
                //       setTechStackIdx(input['프론트엔드']['stack'], '프론트엔드'),
                //       "second": "FRONTEND"
                //     },
                //     {
                //       "first": setTechStackIdx(input['디자이너']['stack'], '디자이너'),
                //       "second": "DESIGNER"
                //     }
                //   ]
                // };
                // createProject(projectInfo);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width * 0.45,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(
                    width: 1.5,
                    color: Colors.white24,
                  ),
                  gradient: LinearGradient(
                      colors: [
                        HexColor("4F34F3"),
                        HexColor("3EF7FF"),
                      ],
                      begin: FractionalOffset(1.0, 0.0),
                      end: FractionalOffset(0.0, 0.0),
                      stops: [0, 1],
                      tileMode: TileMode.clamp),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  '생성',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          )
        : Container(
            padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
            child: Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * 0.45,
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
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )));
  }
}
