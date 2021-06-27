import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../user_auth/authenticate.dart';
import '../../models/project.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';

class ProjectToBeCreated with ChangeNotifier {
  Authenticate _authProvider;
  Project _projectToBeCreated;
  bool loading = false;

  ProjectToBeCreated(projectInfo) {
    createProject(projectInfo);
  }

  Project get projectToBeCreated => _projectToBeCreated;

  set authProvider(Authenticate authProvider) => _authProvider = authProvider;

  Future createProject(dynamic projectInfo) async {
    try {
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();
      await HttpRequest()
          .post(path: "/project", body: projectInfo, authToken: authToken)
          .then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          _projectToBeCreated = json.decode(jsonUtf8)["data"];
        }
        if (response.statusCode == 401) {
          print("프로젝트를 생성하려면 로그인이 필요합니다.");
          // alert message confirm 후 redirect 시키기
          // context 사용하지 않고 navigation 구현하는 GetX라는 라이브러리도 있네요.
          // Get.to(MyPage())
        }
        if (response.statusCode == 403) {
          print("Forbidden");
        }
        if (response.statusCode == 404) {
          print("프로젝트 생성에 필요한 정보를 모두 채워야 합니다.");
        }
      });
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }
}
