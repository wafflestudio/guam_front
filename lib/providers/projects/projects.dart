import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../user_auth/authenticate.dart';
import '../../models/project.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';

class Projects with ChangeNotifier {
  Authenticate _authProvider;
  List<Project> _projects;
  List<Project> _almostFullProjects;
  List<Project> _filteredProjects;
  Project _projectToBeCreated;
  Project _projectToBeApplied;
  bool loading = false;

  Projects() {
    fetchProjects();
  }

  List<Project> get projects => _projects;

  List<Project> get almostFullProjects => _almostFullProjects;

  List<Project> get filteredProjects => _filteredProjects;

  Project get projectToBeCreated => _projectToBeCreated;

  Project get projectToBeApplied => _projectToBeApplied;

  set authProvider(Authenticate authProvider) => _authProvider = authProvider;

  Future fetchProjects() async {
    try {
      loading = true;

      await HttpRequest().get(path: "/project/list").then((response) {
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

  Future getProject(int projectId) async {
    try {
      loading = true;

      await HttpRequest().get(path: "/project/$projectId").then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          _projectToBeApplied = json.decode(jsonUtf8)["data"];
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
        }
        if (response.statusCode == 401) {
          print("프로젝트를 검색하려면 로그인이 필요합니다.");
        }
        if (response.statusCode == 403) {
          print("검색 권한이 없습니다.");
        }
        if (response.statusCode == 404) {
          print("검색된 결과가 존재하지 않습니다.");
        }
      });

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future createProject({Map<String, dynamic> fields, dynamic files}) async {
    try {
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();
      bool res = false;

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .postMultipart(
              path: "/project",
              authToken: authToken,
              fields: {"title": "ㅗㅗㅗ", "due": "THREE", "description": "ㅛ", "backHeadCnt": "1", "designHeadCnt": "2", "frontHeadCnt": "3", "myPosition": "FRONTEND", "frontStackId": "1", "backStackId": "2", "designStackId": "3"},
              files: files,
            )
            .then((response) {
              print(response.statusCode);
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            _projectToBeCreated = json.decode(jsonUtf8)["data"];
            print("프로젝트가 생성되었습니다.");
            res = true;
          }
          if (response.statusCode == 400) {
            print("불충분한 정보입니다");
          }
          if (response.statusCode == 401) {
            print("프로젝트를 생성하려면 로그인이 필요합니다.");
          }
          if (response.statusCode == 403) {
            print("최대 3개의 프로젝트에만 참여할 수 있습니다.");
          }
          if (response.statusCode == 404) {
            print("프로젝트 생성에 필요한 정보를 모두 채워야 합니다.");
          }
        });
      }
      return res;
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }

  // Future createProject(dynamic queryParams) async {
  //   try {
  //     loading = true;
  //     String authToken = await _authProvider.getFirebaseIdToken();
  //     bool res = false;
  //
  //     if (authToken.isNotEmpty) {
  //       await HttpRequest()
  //           .post(path: "/project", body: queryParams, authToken: authToken)
  //           .then((response) {
  //         if (response.statusCode == 200) {
  //           final jsonUtf8 = decodeKo(response);
  //           _projectToBeCreated = json.decode(jsonUtf8)["data"];
  //           print("프로젝트가 생성되었습니다.");
  //           res = true;
  //         }
  //         if (response.statusCode == 400) {
  //           print("불충분한 정보입니다");
  //         }
  //         if (response.statusCode == 401) {
  //           print("프로젝트를 생성하려면 로그인이 필요합니다.");
  //           // alert message confirm 후 redirect 시키기
  //           // context 사용하지 않고 navigation 구현하는 GetX라는 라이브러리도 있네요.
  //           // Get.to(MyPage())
  //         }
  //         if (response.statusCode == 403) {
  //           print("최대 3개의 프로젝트에만 참여할 수 있습니다.");
  //         }
  //         if (response.statusCode == 404) {
  //           print("프로젝트 생성에 필요한 정보를 모두 채워야 합니다.");
  //         }
  //       });
  //     }
  //     return res;
  //   } catch (e) {
  //     print(e);
  //   } finally {
  //     loading = false;
  //   }
  // }

  Future applyProject(int projectId, dynamic queryParams) async {
    try {
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();
      bool res = false;

      if (authToken.isNotEmpty) {
        await HttpRequest()
            .post(path: "/project/$projectId", body: queryParams, authToken: authToken)
            .then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            _projectToBeCreated = json.decode(jsonUtf8)["data"];
            print("프로젝트에 신청하였습니다.");
            res = true;
          }
          if (response.statusCode == 400) {
            print("불충분한 정보입니다");
          }
          if (response.statusCode == 401) {
            print("프로젝트에 신청하려면 로그인이 필요합니다.");
            // alert message confirm 후 redirect 시키기
            // context 사용하지 않고 navigation 구현하는 GetX라는 라이브러리도 있네요.
            // Get.to(MyPage())
          }
          if (response.statusCode == 403) {
            print("지원하진 포지션은 이미 마감되었습니다.");
          }
          if (response.statusCode == 404) {
            print("존재하지 않거나 이미 마감된 프로젝트입니다.");
          }
        });
      }
      return res;
    } catch (e) {
      print(e);
    } finally {
      loading = false;
    }
  }
}
