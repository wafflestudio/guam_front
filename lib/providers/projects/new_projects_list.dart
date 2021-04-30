import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../../models/project.dart';
import '../../helpers/http_request.dart';

class NewProjectsList with ChangeNotifier {
  List<Project> _newProjects;
  bool loading = false;

  NewProjectsList({@required String authToken}) {
    fetchNewProjectsList(authToken);
  }

  List<Project> get newProjects => _newProjects;

  Future fetchNewProjectsList(String authToken) async {
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
        {'id': 1, "title": 'Prj a', 'difficulty': 1, 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
        {'id': 2, "title": 'Prj a', 'difficulty': 1, 'devType': '웹', 'frontFramework': 'Flutter', 'frontHeadCount': 2, 'backFramework': "Spring boot", 'backHeadCount': 2, 'isRecruiting': true},
      ];

      _newProjects = newProjects.map((e) => Project.fromJson(e)).toList();

      print("new projects ; $_newProjects");
      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
