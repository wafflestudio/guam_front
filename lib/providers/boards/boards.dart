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
      profileImage: "https://pbs.twimg.com/profile_images/1319185470207606790/1R89vuMT_400x400.jpg",
      githubLink: "gajagajago@github.com",
      websiteLink: "bla@blah.com",
      skillSet: ["Flutter", "Rails"],
      introduction: "hello hi",
      createdAt: DateTime.now(),
    );

    Profile sampleUser2 = Profile(
      id: 1,
      nickname: "임시유저2",
      profileImage: "https://item.kakaocdn.net/do/d84248170c2c52303db27306a00fb861f604e7b0e6900f9ac53a43965300eb9a",
      githubLink: "gajagajago@github.com",
      websiteLink: "bla@blah.com",
      skillSet: ["Flutter", "Rails"],
      introduction: "hello hi",
      createdAt: DateTime.now(),
    );

    Thread sampleNotice = Thread(
      id: 1,
      creator: sampleUser,
      content: "이곳에는 공지글로 게시된 스레드가 올라옵니다! \n 공지글은 접을 수 있도록 만들 예정입니다. ",
      comments: [],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    Thread sampleThread1 = Thread(
      id: 1,
      creator: sampleUser,
      content: "이곳에는 sample user 1이 작성한 자기소개가 들어갑니다. \n ex) 안녕하세요! 저는 Swift / Django 개발자입니다! \n백엔드 개발을 희망합니다 ^_^",
      comments: [],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    Thread sampleThread2 = Thread(
      id: 1,
      creator: sampleUser2,
      content: "이곳에는 sample user 2가 작성한 자기소개가 들어갑니다. \n ex) Code makes life perfect! 저는 Flutter 개발자입니다 반가워용 ㅎㅎ",
      comments: [],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    List<UserProgress> sampleProgresses = [
      UserProgress(user: sampleUser, progress: "k8s deploy infra 구축 & MySQL DB"),
      UserProgress(user: sampleUser2, progress: "카카오 소셜 로그인 iOS FE 개발"),
      UserProgress(user: sampleUser, progress: "열심히 하고 있습니다"),
      UserProgress(user: sampleUser, progress: "열심히 하고 있습니다"),
    ];

    List<Thread> sampleThreads = [
      sampleThread1,
      sampleThread2,
      sampleThread1,
      sampleThread2,
      sampleThread1,
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
