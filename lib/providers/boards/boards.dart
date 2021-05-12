import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import '../../models/project.dart';
import '../../models/boards/thread.dart';
import '../../models/boards/user_progress.dart';
import '../../models/project.dart';
import '../../models/profile.dart';
import '../../helpers/http_request.dart';

class Boards with ChangeNotifier {
  List<Project> _boards;
  bool loading = false;

  get boards => _boards;

  Boards({@required String authToken}) {
    fetchBoards(authToken);
  }

  Future fetchBoards(String authToken) async {
    /* get rid of these fields after axios attachment done and factory */
    Profile sampleUser = Profile(
      id: 1,
      nickname: "임시유저1",
      profileImage: "https://e7.pngegg.com/pngimages/304/275/png-clipart-user-profile-computer-icons-profile-miscellaneous-logo-thumbnail.png",
      githubLink: "gajagajago@github.com",
      websiteLink: "bla@blah.com",
      skillSet: ["Flutter", "Rails"],
      introduction: "hello hi",
      createdAt: DateTime.now(),
    );

    Thread sampleNotice = Thread(
      id: 1,
      creator: sampleUser,
      content: "@waffleno1 In this file, typography is defined through text styles. Colors and states are built as color styles.",
      comments: [],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    List<UserProgress> sampleProgresses = [
      UserProgress(user: sampleUser, progress: "열심히 하고 있습니다"),
      UserProgress(user: sampleUser, progress: "열심히 하고 있습니다"),
      UserProgress(user: sampleUser, progress: "열심히 하고 있습니다"),
      UserProgress(user: sampleUser, progress: "열심히 하고 있습니다"),
    ];

    List<Thread> sampleThreads = [
      sampleNotice,
      sampleNotice,
      sampleNotice,
      sampleNotice,
      sampleNotice,
    ];
    /* Get rid of all the above unnecessary fields */


    try {
      loading = true;
      // http request for my boards
      _boards = [
        Project(
          id: 1,
          title: "유튜브 제작하기",
          isRecruiting: false,
          notice: sampleNotice,
          progresses: sampleProgresses,
          threads: sampleThreads,
        ),
        Project(
          id: 2,
          title: "지그재그 카피앱 만들기",
          isRecruiting: false,
          notice: sampleNotice,
          progresses: sampleProgresses,
          threads: sampleThreads,
        ),
        Project(
          id: 3,
          title: "제 2의 GUAM 만들기",
          isRecruiting: false,
          notice: sampleNotice,
          progresses: sampleProgresses,
          threads: sampleThreads,
        ),
      ];

      loading = false;
    } catch (e) {

    } finally {
      notifyListeners();
    }
  }

}
