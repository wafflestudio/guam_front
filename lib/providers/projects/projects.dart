import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../user_auth/authenticate.dart';
import '../../models/project.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';

class Projects with ChangeNotifier {
  Authenticate
      _authProvider; // Post 등은 이 authProvider 에 들어있는 firebaseToken 을 참조하여 날리시면 됩니다.
  List<Project> _projects;
  List<Project> _almostFullProjects;
  List<Project> _filteredProjects;
  bool loading = false;

  Projects() {
    fetchProjects();
  }

  List<Project> get projects => _projects;

  List<Project> get almostFullProjects => _almostFullProjects;

  List<Project> get filteredProjects => _filteredProjects;

  set authProvider(Authenticate authProvider) => _authProvider = authProvider;

  Future fetchProjects() async {
    try {
      loading = true;

      await HttpRequest()
          .get(
        path: "/project/list",
      )
          .then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
          _projects = jsonList.map((e) => Project.fromJson(e)).toList();
        }
      });

      await HttpRequest()
          .get(
        path: "/project/tab",
      )
          .then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
          _almostFullProjects =
              jsonList.map((e) => Project.fromJson(e)).toList();
        }
      });

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future searchProjects(dynamic queryParams) async {
    try {
      loading = true;

      await HttpRequest()
          .get(path: "/project/search", queryParams: queryParams)
          .then((response) {
        print(response.statusCode);
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
          _filteredProjects = jsonList.map((e) => Project.fromJson(e)).toList();
        }
      });

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
