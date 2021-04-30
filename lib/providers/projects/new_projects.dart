import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../../models/project.dart';
import '../../helpers/http_request.dart';

class NewProjects with ChangeNotifier {
  List<Project> _newProjects;
  bool loading = false;

  NewProjects({@required String authToken}) {
    fetchNewProjects(authToken);
  }

  List<Project> get newProjects => _newProjects;

  Future fetchNewProjects(String authToken) async {
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
      List<Map<String, dynamic>> newProjects = [
        {'id': 1, "title": 'StackOverFlow 토이 프로젝트', 'difficulty': 1, 'thumbnail': "https://upload.wikimedia.org/wikipedia/commons/f/f7/Stack_Overflow_logo.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 2, "title": 'Youtube 제작하기', 'difficulty': 1, 'thumbnail': "https://blog.kakaocdn.net/dn/BFi6P/btqu2a0vtPj/Yz8dSCZronFkrwkGxZ2PQ1/img.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 3, "title": '커플앱 비트윈 카피앱 제작하기', 'difficulty': 1, 'thumbnail': "https://dtqvguqpjeirn.cloudfront.net/static/img/kr_jobs/ic_web_jobs_vision2@3x.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 4, "title": '카카오톡 만들기', 'difficulty': 1, 'thumbnail': "https://upload.wikimedia.org/wikipedia/commons/thumb/d/de/Kakao_CI_yellow.svg/1200px-Kakao_CI_yellow.svg.png", 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},

      ];

      _newProjects = newProjects.map((e) => Project.fromJson(e)).toList();

      print("new projects[0]: ${newProjects[0]}");
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
