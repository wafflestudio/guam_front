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
  Project _projectToBeEdited;
  List<Project> _projects;
  List<Project> _almostFullProjects;
  List<Project> _filteredProjects;
  bool loading = false;

  Projects() {
    fetchProjects();
  }

  Project get projectToBeEdited => _projectToBeEdited;

  List<Project> get projects => _projects;

  List<Project> get almostFullProjects => _almostFullProjects;

  List<Project> get filteredProjects => _filteredProjects;

  set authProvider(Authenticate authProvider) => _authProvider = authProvider;

  Future fetchProjects() async {
    loading = true;

    try {
      await Future.wait([
        getAllProjects(),
        getAlmostFullProjects(),
      ]);
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future getAllProjects() {
    return HttpRequest().get(path: "/project/list").then((response) {
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
  }

  Future getAlmostFullProjects() {
    return HttpRequest().get(path: "/project/tab").then((response) {
      if (response.statusCode == 200) {
        final jsonUtf8 = decodeKo(response);
        final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
        _almostFullProjects = jsonList.map((e) => Project.fromJson(e)).toList();
      } else {
        final jsonUtf8 = decodeKo(response);
        final String err = json.decode(jsonUtf8)["message"];
        showToast(success: false, msg: err);
      }
    });
  }

  Future<Project> getProject(int projectId) async {
    Project project;

    try {
      await HttpRequest()
        .get(path: "/project/$projectId")
        .then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            project = Project.fromJson(json.decode(jsonUtf8)["data"]);
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
          }
      });
    } catch (e) {
      print(e);
    }

    return project;
  }

  Future<void> searchProjects(dynamic queryParams) async {
    loading = true;

    try {
      await HttpRequest()
        .get(path: "/project/search", queryParams: queryParams)
        .then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
            _filteredProjects = jsonList.map((e) => Project.fromJson(e)).toList();
            showToast(success: true, msg: "???????????? ?????? ??????");
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

  Future<bool> createProject({Map<String, dynamic> fields, dynamic files}) async {
    bool successful = false;
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
          .postMultipart(
            path: "/project",
            authToken: authToken,
            fields: fields,
            files: files,
          ).then((response) {
            if (response.statusCode == 200) {
              showToast(success: true, msg: "??????????????? ?????????????????????.");
              successful = true;
            } else {
              response.stream.bytesToString().then((val) {
                final String err = json.decode(val)["message"];
                showToast(success: false, msg: err);
              });
            }
          });
      }
    } catch (e) {
      showToast(success: false, msg: e.message);
    } finally {
      loading = false;
    }

    return successful;
  }

  Future<bool> applyProject({int projectId, dynamic queryParams}) async {
    bool res = false;
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
          .post(path: "/project/$projectId", body: queryParams, authToken: authToken)
          .then((response) async {
            if (response.statusCode == 200)  {
              showToast(success: true, msg: "??????????????? ?????????????????????.");
              res = true;
            } else {
              final jsonUtf8 = decodeKo(response);
              final String err = json.decode(jsonUtf8)["message"];
              showToast(success: false, msg: err);
            }
        });
      }
    } catch (e) {
      showToast(success: false, msg: e.message);
    } finally {
      loading = false;
    }

    return res;
  }
}
