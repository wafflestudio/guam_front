import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_front/models/boards/comment.dart';
import 'dart:convert';
import '../../models/project.dart';
import '../../models/boards/thread.dart';
import '../../models/boards/user_task.dart';
import '../../models/project.dart';
import '../../models/profile.dart';
import '../../helpers/http_request.dart';
import '../user_auth/authenticate.dart';
import '../../helpers/decode_ko.dart';
import 'package:http/http.dart' as http;

class Boards with ChangeNotifier {
  Authenticate _authProvider;

  List<Project> _boards;
  int _renderBoardIdx = 0;
  bool loading = false;

  get boards => _boards;
  get renderBoardIdx => _renderBoardIdx;
  get currentBoard => boards[renderBoardIdx];

  set renderBoardIdx(idx) {
    _renderBoardIdx = idx;
    notifyListeners();
  }

  void prev() {
    renderBoardIdx = (renderBoardIdx - 1) % _boards.length;
  }

  void next() {
    renderBoardIdx = (renderBoardIdx + 1) % _boards.length;
  }

  Boards(Authenticate authProvider) {
    _authProvider = authProvider;
    fetchBoardIds();
  }

  Future fetchBoardIds() async {
    try {
      print("Fetching board ids");
      loading = true;

      if (_authProvider.userSignedIn()) {
        await HttpRequest().get(
          path: "user/project/ids",
          authToken: await _authProvider.getFirebaseIdToken()
        ).then((response) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
          _boards = jsonList.map((e) => Project.fromJson({ "id": e })).toList();
        });
      }
    } catch (e) {
      print(e);
    } finally {
      print("Fetching board ids -- DONE");
      notifyListeners();
    }
  }

  Future fetchBoard(int projectId) async {
    try {
      print("Fetching boards");
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .get(
          path: "/project/$projectId",
          authToken: authToken
        ).then((response) {
          final jsonUtf8 = decodeKo(response);
          final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
          boards[renderBoardIdx] = Project.fromJson(jsonData);
      });

      await fetchThreads(projectId);

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
      print("Fetching boards -- DONE");
    }
  }

  Future fetchThreads(int projectId) async {
    try {
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .get(
          path: "project/$projectId/threads",
          authToken: authToken,
      ).then((response) {
        final jsonUtf8 = decodeKo(response);
        final List<dynamic> jsonData = json.decode(jsonUtf8)["data"];
        final List<Thread> threads = [...jsonData.map((e) => Thread.fromJson(e))];
        boards[renderBoardIdx].threads = threads;
      });

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future fetchFullThread(int threadId) async {
    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .get(
          path: "/thread/$threadId",
          authToken: authToken
      ).then((response) {
        final jsonUtf8 = decodeKo(response);
        final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
        final List<Comment> comments = [...jsonData["comments"].map((e) => Comment.fromJson(e))];
        print("Fetching full thread -- DONE");
        return comments;
      });
    } catch (e) {
      print(e);
    }
  }

  Future postThread(dynamic body) async {
    try {
      String authToken = await _authProvider.getFirebaseIdToken();
      bool res = false;
      /*
      * 진우님이 Authorization 코드 넣기 전까지 temp code
      * Authorization 으로 header 에 넣게 되면 "USER-ID" 필요 없어지므로 HttpRequest() 사용
      * */
      final path = "/thread/create/${currentBoard.id}";
      final uri = Uri.http(HttpRequest().baseAuthority, path);
      await http
        .post(
          uri,
          headers: {'Content-Type': "application/json", "USER-ID": "${_authProvider.me.id}"},
          body: json.encode(body)
      ).then((response) {
        if (response.statusCode == 200) {
          print("스레드가 등록되었습니다.");
          res = true;
        }
      });

      return res;
    } catch (e) {
      print(e);
    } finally {
      fetchThreads(currentBoard.id);
    }
  }


}
