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

class Boards with ChangeNotifier {
  Authenticate _authProvider;

  List<Project> _boards;
  int _renderBoardIdx = 0;
  bool loading = false;

  get boards => _boards;
  get renderBoardIdx => _renderBoardIdx;

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

  Future fetchBoard(int id) async {
    try {
      print("Fetching boards");
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .get(
          path: "/project/$id",
          authToken: authToken
        ).then((response) {
          final jsonUtf8 = decodeKo(response);
          final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
          boards[renderBoardIdx] = Project.fromJson(jsonData);
      });

      await fetchThreads(id);

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
      print("Fetching boards -- DONE");
    }
  }

  Future fetchThreads(int id) async {
    try {
      loading = true;
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .get(
          path: "project/$id/threads",
          authToken: authToken,
      ).then((response) {
        final jsonUtf8 = decodeKo(response);
        final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
        final List<Thread> threads = [...jsonData["content"].map((e) => Thread.fromJson(e))];
        boards[renderBoardIdx].threads = threads;
      });

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }
}
