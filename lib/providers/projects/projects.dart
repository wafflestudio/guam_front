import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../user_auth/authenticate.dart';
import '../../models/project.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';
import '../../mixins/toast.dart';

class Projects extends ChangeNotifier with Toast {
  Authenticate _authProvider;
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

      await HttpRequest().get(path: "/project/list").then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
          _projects = jsonList.map((e) => Project.fromJson(e)).toList();
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });

      await HttpRequest().get(path: "/project/tab").then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
          _almostFullProjects =
              jsonList.map((e) => Project.fromJson(e)).toList();
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future getProject(int projectId) async {
    try {
      loading = true;

      await HttpRequest()
        .get(path: "/project/$projectId")
        .then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            return Project.fromJson(json.decode(jsonUtf8)["data"]);
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
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
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
            _filteredProjects = jsonList.map((e) => Project.fromJson(e)).toList();
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
          }
      });
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future createProject({Map<String, dynamic> fields, dynamic files}) async {
    bool res = false;

    try {
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
          .postMultipart(
            path: "/project",
            authToken: authToken,
            fields: fields,
            files: files,
          ).then((response) async {
            if (response.statusCode == 200) {
              showToast(success: true, msg: "프로젝트가 생성되었습니다.");
              res = true;
            } else {
              final jsonUtf8 = decodeKo(response);
              final String err = json.decode(jsonUtf8)["message"];
              showToast(success: false, msg: err);
            }
          });
      }
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }

    return res;
  }

  Future applyProject(int projectId, dynamic queryParams) async {
    bool res = false;

    try {
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
          .post(path: "/project/$projectId", body: queryParams, authToken: authToken)
          .then((response) async {
            if (response.statusCode == 200)  {
              showToast(success: true, msg: "프로젝트에 신청하였습니다.");
              res = true;
            } else {
              final jsonUtf8 = decodeKo(response);
              final String err = json.decode(jsonUtf8)["message"];
              showToast(success: false, msg: err);
            }
        });
      }
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }

    return res;
  }
}
