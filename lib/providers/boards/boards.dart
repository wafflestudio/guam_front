import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_front/models/boards/comment.dart';
import 'dart:convert';
import '../../models/project.dart';
import '../../models/boards/thread.dart';
import '../../helpers/http_request.dart';
import '../user_auth/authenticate.dart';
import '../../helpers/decode_ko.dart';
import '../../models/boards/user_task.dart';

class Boards with ChangeNotifier {
  Authenticate _authProvider;

  List<Project> _boards;
  int _renderBoardIdx = 0;
  bool loading = false;

  Map<int, Color> renderBoardColor = {
    0: Color.fromRGBO(112, 255, 0, 0.6),
    1: Color.fromRGBO(0, 141, 232, 0.6),
    2: Color.fromRGBO(255, 179, 116, 1),
  };

  get boards => _boards;
  get renderBoardIdx => _renderBoardIdx;
  get currentBoard => boards[renderBoardIdx];

  bool isMe(int userId) => _authProvider.me.id == userId;

  set renderBoardIdx(idx) {
    _renderBoardIdx = idx;
    notifyListeners();
  }

  /* Deprecated code used for boards navigation.
  void prev() {
    renderBoardIdx = (renderBoardIdx - 1) % _boards.length;
  }

  void next() {
    renderBoardIdx = (renderBoardIdx + 1) % _boards.length;
  }
   */

  Boards(Authenticate authProvider) {
    _authProvider = authProvider;
    fetchBoardIds();
  }

  Future fetchBoardIds() async {
    try {
      loading = true;

      if (_authProvider.userSignedIn()) {
        await HttpRequest()
          .get(
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
      notifyListeners();
    }
  }

  Future fetchBoard(int projectId) async {
    try {
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

      await setTasks();
      await fetchThreads(projectId);

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future setTasks() async {
    List<UserTask> newTasks = [];

    for (UserTask task in currentBoard.tasks) {
      newTasks.add(await fetchTask(task.id));
    }

    currentBoard.tasks = newTasks;
  }

  Future<UserTask> fetchTask(int taskId) async {
    UserTask userTask;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest().get(
        path: "/task/$taskId",
        authToken: authToken
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
          userTask = UserTask.fromJson(jsonData);
        } else {
          throw new Exception("Task not found.");
        }
      });
    } catch (e) {
      print(e);
    }

    return userTask;
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
        currentBoard.threads = threads;
      });

      loading = false;
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  // threads provider 로 분리하는 게 어떨지?

  Future<List<Comment>> fetchFullThread(int threadId) async {
    List<Comment> comments;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .get(
          path: "/thread/$threadId",
          authToken: authToken
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
          comments = [...jsonData["comments"].map((e) => Comment.fromJson(e))];
        } else {
          throw new Exception();
        }
      });
    } catch (e) {
      print(e);
    }

    return comments;
  }

  Future postThread({Map<String, dynamic> fields, dynamic files}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .postMultipart(
          path: "/thread/create/${currentBoard.id}",
          authToken: authToken,
          fields: fields,
          files: files,
      ).then((response) {
        if (response.statusCode == 200) {
          print("스레드가 등록되었습니다.");
          res = true;
        } else {
          throw new Exception();
        }
      });

      return res;
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads(currentBoard.id);
    }
  }

  Future editThreadContent({int threadId, Map<String, dynamic> fields}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .put(
          path: "/thread/$threadId/content",
          authToken: authToken,
          body: fields,
      ).then((response) {
        if (response.statusCode == 200) {
          print("스레드가 수정되었습니다.");
          res = true;
        } else {
          throw new Exception();
        }
      });

      return res;
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads(currentBoard.id);
    }
  }

  Future setNotice(int threadId) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .put(
          path: "/project/${currentBoard.id}/notice/$threadId",
          authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          print("스레드가 고정되었습니다.");
          res = true;
        } else {
          throw new Exception();
        }
      });

      return res;
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchBoard(currentBoard.id);
    }
  }

  Future deleteThread(int threadId) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .delete(
          path: "/thread/$threadId",
          authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          print("스레드가 삭제되었습니다.");
          res = true;
        } else {
          throw new Exception();
        }
      });

      return res;
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads(currentBoard.id);
    }
  }

  Future postComment({int threadId, Map<String, dynamic> fields, dynamic files}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .postMultipart(
          authToken: authToken,
          path: "/comment/create/$threadId",
          fields: fields,
          files: files,
      ).then((response) {
        if (response.statusCode == 200) {
          print("답글이 등록되었습니다.");
          res = true;
        } else {
          throw new Exception();
        }
      });

      return res;
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads(currentBoard.id);
    }
  }

  Future editCommentContent({int commentId, Map<String, dynamic> fields}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .put(
          path: "/comment/$commentId/content",
          authToken: authToken,
          body: fields,
      ).then((response) {
        if (response.statusCode == 200) {
          print("답글이 수정되었습니다.");
          res = true;
        } else {
          throw new Exception();
        }
      });

      return res;
    } catch (e) {
      print(e);
    }
  }

  Future deleteComment(int commentId) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .delete(
          path: "/comment/$commentId",
          authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          print("답글이 삭제되었습니다.");
          res = true;
        } else {
          throw new Exception();
        }
      });

      return res;
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads(currentBoard.id);
    }
  }

  Future acceptDecline({int userId, bool accept}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .post(
          path: "/project/${currentBoard.id}/$userId",
          authToken: authToken,
          queryParams: { "accept": "$accept" }
      ).then((response) {
        if (response.statusCode == 200) {
          print("${accept ? "승인" : "반려"}가 완료되었습니다.");
          res = true;
        } else {
          throw new Exception("오직 프로젝트 리더만 승인/반려가 가능합니다.");
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) {
        fetchBoard(currentBoard.id);
        fetchThreads(currentBoard.id);
      }
    }
  }
}
