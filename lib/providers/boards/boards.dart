import 'dart:math';
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
import '../../mixins/toast.dart';

class Boards extends ChangeNotifier with Toast {
  Authenticate _authProvider;

  List<Project> _boards;
  int _renderBoardIdx = 0;
  final int _defaultThreadsPage = 0;
  final int _defaultThreadsSize = 10;
  bool loading = false;

  Map<int, Color> renderBoardColor = {
    0: Color.fromRGBO(112, 255, 0, 0.6),
    1: Color.fromRGBO(0, 141, 232, 0.6),
    2: Color.fromRGBO(255, 179, 116, 1),
  };

  get boards => _boards;
  get renderBoardIdx => _renderBoardIdx;
  get defaultThreadsSize => _defaultThreadsSize;
  get defaultThreadsPage => _defaultThreadsPage;
  get currentBoard => boards[renderBoardIdx];

  bool isMe(int userId) => _authProvider.me.id == userId;

  set renderBoardIdx(idx) {
    _renderBoardIdx = idx;
    notifyListeners();
  }

  Boards(Authenticate authProvider) {
    _authProvider = authProvider;
    fetchBoardIds();
  }

  Future<void> fetchBoardIds() async {
    loading = true;

    try {
      if (_authProvider.userSignedIn()) {
        await HttpRequest()
          .get(
            path: "user/project/ids",
            authToken: await _authProvider.getFirebaseIdToken()
          ).then((response) {
            if (response.statusCode == 200) {
              final jsonUtf8 = decodeKo(response);
              final List<dynamic> jsonList = json.decode(jsonUtf8)["data"];
              _boards = jsonList.map((e) => Project.fromJson({ "id": e })).toList();
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
      notifyListeners();
    }
  }

  Future<void> fetchBoard(int projectId) async {
    print("Start fetching board");  ///
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .get(
          path: "/project/$projectId",
          authToken: authToken
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
            boards[renderBoardIdx] = Project.fromJson(jsonData);
            print("Finished fetching board info");  ///
          } else {
            final jsonUtf8 = decodeKo(response);
            final String err = json.decode(jsonUtf8)["message"];
            showToast(success: false, msg: err);
          }
      });

      // 순서 중요! Thread.dart 에서 task
      await setTasks();
      await fetchThreads();
    } catch (e) {
      print(e);
    } finally {
      loading = false;
      notifyListeners();
    }
  }

  Future<bool> editProject({int projectId, Map<String, dynamic> fields, dynamic files}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      if (authToken.isNotEmpty) {
        await HttpRequest()
          .postMultipart(
            path: "/project/$projectId/edit",
            authToken: authToken,
            fields: fields,
            files: files,
          ).then((response) {
            if (response.statusCode == 200) {
              res = true;
              showToast(success: true, msg: "프로젝트를 수정했습니다.");
            } else {
              response.stream.bytesToString().then((val) {
                final String err = json.decode(val)["message"];
                showToast(success: false, msg: err);
              });
            }
          });
      }
    } catch (e) {
      print(e);
    }

    return res;
  }

  Future<void> setTasks() async {
    print("Start set tasks"); ///
    List<UserTask> newTasks = [];

    for (UserTask briefTask in currentBoard.tasks) {
      UserTask detailedTask = await fetchTask(briefTask.id);

      // Position my task initially at front.
      if (isMe(detailedTask.user.id)) newTasks.insert(0, detailedTask);
      else newTasks.add(detailedTask);
    }

    currentBoard.tasks = newTasks;
    print("Finished set tasks");  ///
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
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    }

    return userTask;
  }

  Future<bool> createTaskMsg({int taskId, Map<String, String> body}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .post(
          path: "task/$taskId",
          authToken: authToken,
          body: body,
      ).then((response) async {
        if (response.statusCode == 200) {
          res = true;
          showToast(success: true, msg: "작업현황이 생성되었습니다.");
          await setTasks();
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }

    return res;
  }

  Future<void> updateTaskMsg({int taskMsgId, Map<String, String> body}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .put(
          path: "taskMsg/$taskMsgId",
          authToken: authToken,
          body: body,
      ).then((response) async {
        if (response.statusCode == 200) {
          res = true;
          await setTasks();
          // Too minor to display success toast.. so skip toast
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }

    return res;
  }

  Future deleteTaskMsg({int taskMsgId}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .delete(
          path: "taskMsg/$taskMsgId",
          authToken: authToken,
      ).then((response) async {
        if (response.statusCode == 200) {
          res = true;
          await setTasks();
          showToast(success: true, msg: "작업현황을 삭제했습니다.");
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }

    return res;
  }

  Future fetchThreads({dynamic queryParams}) async {
    print("Start fetch threads"); ///
    loading = true;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .get(
          path: "project/${currentBoard.id}/threads",
          authToken: authToken,
          queryParams: queryParams ?? {
            "size": "$defaultThreadsSize",
            "page": "$defaultThreadsPage",
          },
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonData = json.decode(jsonUtf8)["data"];
          final List<Thread> threads = [...jsonData.map((e) => Thread.fromJson(e))];
          currentBoard.threads = threads;
          print("Finished fetch threads"); ///
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
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    }

    return comments;
  }

  Future<bool> postThread({Map<String, dynamic> fields, dynamic files}) async {
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
          showToast(success: true, msg: "스레드가 등록되었습니다.");
          res = true;
        } else {
          response.stream.bytesToString().then((val) {
            final String err = json.decode(val)["message"];
            showToast(success: false, msg: err);
          });
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads();
    }

    return res;
  }

  Future<bool> editThreadContent({int threadId, Map<String, dynamic> fields}) async {
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
          showToast(success: true, msg: "스레드가 수정되었습니다.");
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads();
    }

    return res;
  }

  Future<bool> setNotice(int threadId) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .put(
          path: "/project/${currentBoard.id}/notice/$threadId",
          authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          showToast(success: true, msg: "스레드가 고정되었습니다.");
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchBoard(currentBoard.id);
    }

    return res;
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
          showToast(success: true, msg: "스레드가 삭제되었습니다.");
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads();
    }

    return res;
  }

  Future<bool> deleteThreadImage({int threadId, int imageId}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .delete(
         path: "/thread/$threadId/image/$imageId",
         authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          showToast(success: true, msg: "이미지가 삭제되었습니다.");
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads();
    }

    return res;
  }

  Future<bool> postComment({int threadId, Map<String, dynamic> fields, dynamic files}) async {
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
          showToast(success: true, msg: "답글이 등록되었습니다.");
          res = true;
        } else {
          response.stream.bytesToString().then((val) {
            final String err = json.decode(val)["message"];
            showToast(success: false, msg: err);
          });
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads();
    }

    return res;
  }

  Future<bool> editCommentContent({int commentId, Map<String, dynamic> fields}) async {
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
          showToast(success: true, msg: "답글이 수정되었습니다.");
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    }

    return res;
  }

  Future<bool> deleteComment(int commentId) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .delete(
          path: "/comment/$commentId",
          authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          showToast(success: true, msg: "답글이 삭제되었습니다.");
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchThreads();
    }

    return res;
  }

  Future<bool> deleteCommentImage({int commentId, int imageId}) async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .delete(
          path: "/comment/$commentId/image/$imageId",
          authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          showToast(success: true, msg: "이미지가 삭제되었습니다.");
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    }

    return res;
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
          showToast(success: true, msg: "${accept ? "승인이" : "반려가"} 완료되었습니다.");
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) {
        await fetchBoard(currentBoard.id);
      }
    }
  }

  Future quitBoard() async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .post(
          path: "/project/${currentBoard.id}/quit",
          authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          showToast(success: true, msg: "작업실을 나갔습니다.");
          res = true;
          renderBoardIdx = max(_renderBoardIdx - 1, 0);
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchBoardIds();
    }

    return res;
  }

  Future deleteBoard() async {
    bool res = false;

    try {
      String authToken = await _authProvider.getFirebaseIdToken();

      await HttpRequest()
        .delete(
          path: "/project/${currentBoard.id}",
          authToken: authToken,
      ).then((response) {
        if (response.statusCode == 200) {
          showToast(success: true, msg: "작업실을 삭제했습니다.");
          renderBoardIdx = max(_renderBoardIdx - 1, 0);
          res = true;
        } else {
          final jsonUtf8 = decodeKo(response);
          final String err = json.decode(jsonUtf8)["message"];
          showToast(success: false, msg: err);
        }
      });
    } catch (e) {
      print(e);
    } finally {
      if (res) fetchBoardIds();
    }

    return res;
  }
}
