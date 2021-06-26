import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../user_auth/authenticate.dart';
import '../../models/project.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';

class Projects with ChangeNotifier {
  Authenticate _authProvider; // post 등은 이 authProvider에 들어있는 firebaseToken으로 날리시면 됩니다.
  List<Project> _projects;
  List<Project> _almostFullProjects;
  bool loading = false;

  Projects() {
    fetchProjects();
  }

  List<Project> get projects => _projects;
  List<Project> get almostFullProjects => _almostFullProjects;
  set authProvider(Authenticate authProvider) => _authProvider = authProvider;

  Future fetchProjects() async {
    try {
      loading = true;

      await HttpRequest().get(
        path: "/project/list",
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
          print(jsonList.toString());
          _projects = jsonList.map((e) => Project.fromJson(e)).toList();
        }
      });

      await HttpRequest().get(
        path: "/project/tab",
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
          _almostFullProjects = jsonList.map((e) => Project.fromJson(e)).toList();
        }
      });

      // List<Map<String, dynamic>> almostFullProjects = [
      //   {'id': 1, "title": '비트코인 채굴기 만들기', 'description': '비트코인 채굴 프로젝트 해봐요!!!비트코인 채굴 프로젝트 해봐요!!!비트코인 채굴 프로젝트 해봐요!!!비트코인 채굴 프로젝트 해봐요!!!비트코인 채굴 프로젝트 해봐요!!!비트코인 채굴 프로젝트 해봐요!!!', 'time' : 3, 'difficulty': 1, 'thumbnail': "https://i.insider.com/602fd42fd3570b0018092849?width=1136&format=jpeg", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      //   {'id': 2, "title": '시간표 앱 만들기', 'description': '스누티티를 따라잡을 프로젝트 해봐요!!!', 'time' : 3, 'difficulty': 1, 'thumbnail': "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/28/f4/43/28f44329-b3f8-24a0-0c43-bf59eb263881/source/512x512bb.jpg", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      //   {'id': 3, "title": '카풀 앱 제작하기', 'description': '제2의 우버를 만들 프로젝트 해봐요!!!', 'time' : 3, 'difficulty': 1, 'thumbnail': "https://img.hankyung.com/photo/201812/01.18444541.1.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      //   {'id': 4, "title": '교육용 드론 만들기', 'description': 'S/W와 더불어 H/W까지 다뤄보는 프로젝트 해봐요!!!', 'time' : 3, 'difficulty': 1, 'thumbnail': "https://pds.joins.com/news/component/htmlphoto_mmdata/201503/22/htm_20150322111110c010c011.JPG", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      //   {'id': 5, "title": '파이썬 빅데이터 스터디', 'description': '하둡, 스파크와 연동할 수 있는 파이프라인 구축 프로젝트 해봐요!!!', 'time' : 3, 'difficulty': 1, 'thumbnail': "https://img1.daumcdn.net/thumb/R800x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fbd3g53%2FbtqEm3yi9Wf%2FRGX2fyBJrGs5vQQTEIUaK1%2Fimg.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      //   {'id': 6, "title": '배민 카피앱 개발', 'description': '네카라쿠배 그 두번째 단계로 배달의민족 개발을 해봐요!!!', 'time' : 3, 'difficulty': 1, 'thumbnail': "https://pds.joins.com/news/component/htmlphoto_mmdata/201912/03/e157f4c7-2dc7-416c-8a88-d1a3dbfff9e8.jpg", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      // ];
      //
      // _almostFullProjects = almostFullProjects.map((e) => Project.fromJson(e)).toList();

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
