import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../../models/project.dart';
import '../../helpers/http_request.dart';

class Projects with ChangeNotifier {
  List<Project> _projects;
  List<Project> _almostFullProjects;
  bool loading = false;

  Projects({@required String authToken}) {
    fetchProjects(authToken);
  }

  List<Project> get projects => _projects;
  List<Project> get almostFullProjects => _almostFullProjects;

  Future fetchProjects(String authToken) async {
    try {
      loading = true;
      // await HttpRequest()
      //     .get(partialUrl: "products", authToken: authToken)
      //     .then((response) {
      //   if (response.statusCode == 200) {
      //     final List<dynamic> jsonList = json.decode(response.body);
      //     _newProjects = jsonList.map((e) => Project.fromJson(e)).toList();
      //     loading = false;
      //   }
      // });
      List<Map<String, dynamic>> projects = [
        {'id': 1, "title": 'StackOverFlow 토이 프로젝트', 'difficulty': 1, 'thumbnail': "https://jessehouwing.net/content/images/size/w2000/2018/07/stackoverflow-1.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 2, "title": 'Youtube 제작하기', 'difficulty': 1, 'thumbnail': "https://blog.kakaocdn.net/dn/BFi6P/btqu2a0vtPj/Yz8dSCZronFkrwkGxZ2PQ1/img.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 3, "title": '커플앱 비트윈 카피앱 제작하기', 'difficulty': 1, 'thumbnail': "https://dtqvguqpjeirn.cloudfront.net/static/img/kr_jobs/ic_web_jobs_vision2@3x.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 4, "title": '카카오톡 만들기', 'difficulty': 1, 'thumbnail': "https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Kakao_CI_yellow.svg/1200px-Kakao_CI_yellow.svg.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      ];

      _projects = projects.map((e) => Project.fromJson(e)).toList();

      List<Map<String, dynamic>> almostFullProjects = [
        {'id': 1, "title": '비트코인 채굴기 만들기', 'difficulty': 1, 'thumbnail': "https://i.insider.com/602fd42fd3570b0018092849?width=1136&format=jpeg", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 2, "title": '시간표 앱 만들기', 'difficulty': 1, 'thumbnail': "https://is1-ssl.mzstatic.com/image/thumb/Purple118/v4/28/f4/43/28f44329-b3f8-24a0-0c43-bf59eb263881/source/512x512bb.jpg", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 3, "title": '카풀 앱 제작하기', 'difficulty': 1, 'thumbnail': "https://img.hankyung.com/photo/201812/01.18444541.1.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 4, "title": '교육용 드론 만들기', 'difficulty': 1, 'thumbnail': "https://pds.joins.com/news/component/htmlphoto_mmdata/201503/22/htm_20150322111110c010c011.JPG", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      ];

      _almostFullProjects = almostFullProjects.map((e) => Project.fromJson(e)).toList();

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
