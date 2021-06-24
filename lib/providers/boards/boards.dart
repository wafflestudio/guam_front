import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:guam_front/models/boards/comment.dart';
import 'dart:convert';
import '../../models/project.dart';
import '../../models/boards/thread.dart';
import '../../models/boards/user_progress.dart';
import '../../models/project.dart';
import '../../models/profile.dart';
import '../../helpers/http_request.dart';

class Boards with ChangeNotifier {
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

  Boards() {
    fetchBoards();
  }

  Future fetchBoards() async {
    /* get rid of these fields after axios attachment done and factory */
    var profile = Profile(
      id: 1,
      nickname: "임시유저1",
      imageUrl: "https://pbs.twimg.com/profile_images/1319185470207606790/1R89vuMT_400x400.jpg",
      githubUrl: "gajagajago@github.com",
      blogUrl: "bla@blah.com",
      skills: "Flutter",
      introduction: "hello hi",
    );
    Profile sampleUser1 = profile;

    Profile sampleUser2 = Profile(
      id: 2,
      nickname: "라이언",
      imageUrl: "https://item.kakaocdn.net/do/d84248170c2c52303db27306a00fb861f604e7b0e6900f9ac53a43965300eb9a",
      githubUrl: "gajagajago@github.com",
      blogUrl: "bla@blah.com",
      skills: "Flutter",
      introduction: "hello hi",
    );

    Profile sampleUser3 = Profile(
      id: 3,
      nickname: "보라색 냥냥이",
      imageUrl: "https://i.pinimg.com/originals/1b/51/73/1b51731e55bd51232386fb8f8212d8a9.jpg",
      githubUrl: "gajagajago@github.com",
      blogUrl: "bla@blah.com",
      skills: "Flutter",
      introduction: "hello hi",
    );

    Profile sampleUser4 = Profile(
      id: 4,
      nickname: "임시유저2",
      imageUrl: "https://lh3.googleusercontent.com/proxy/JVEzgWFWpGe07IPOy8NuQIa5jB7HYlKzeXKUwYwkWcl0Zm2kZw87oI7Sr35P5DMXfDLeh2cqwOJPeVmKCGQjyZSbyo0VPVTjYi3R8dU3CDW3E-SUZQQ7xD1ErjEv7SE0l7c2i4wUkvJnhF4VBysn5f5oyO2KTA",
      githubUrl: "gajagajago@github.com",
      blogUrl: "bla@blah.com",
      skills: "Flutter",
      introduction: "hello hi",
    );

    Profile sampleUser5 = Profile(
      id: 5,
      nickname: "임시유저2",
      imageUrl: "https://ogu45.com/zbxe/files/attach/images/130/941/078/af453ac54090e18a8fb36e74f2bed903.jpg",
      githubUrl: "gajagajago@github.com",
      blogUrl: "bla@blah.com",
      skills: "Flutter",
      introduction: "hello hi",
    );

    Profile sampleUser6 = Profile(
      id: 6,
      nickname: "임시유저2",
      imageUrl: "https://lh3.googleusercontent.com/proxy/ZNSsJvvwzPDI1RdWC0sD6N0GO5cCvArr3F-Lx-sdTMirI6gwmlOrdiZF59mTpy9SizUbGdCl3dyjF5VY4uKvz5QsSmb1_kXjlBELKh82nkX6KhkVjkDfV6n2bwFOhA",
      githubUrl: "gajagajago@github.com",
      blogUrl: "bla@blah.com",
      skills: "Flutter",
      introduction: "hello hi",
    );

    Thread sampleNotice1 = Thread(
      id: 1,
      creator: sampleUser1,
      content: "이곳에는 공지글로 게시된 스레드가 올라옵니다! \n 공지글은 접을 수 있도록 만들 예정입니다. ",
      comments: [],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    Thread sampleNotice2 = Thread(
      id: 1,
      creator: sampleUser2,
      content: "My android project can connect my phone , but The Flutter project can't connect my phone.",
      comments: [],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    Thread sampleNotice3 = Thread(
      id: 1,
      creator: sampleUser3,
      content: "My android project can connect my phone , but The Flutter project can't connect my phone.",
      comments: [],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    Thread sampleThread1 = Thread(
      id: 1,
      creator: sampleUser1,
      content: "이곳에는 sample user 1이 작성한 자기소개가 들어갑니다. \n ex) 안녕하세요! 저는 Swift / Django 개발자입니다! \n백엔드 개발을 희망합니다 ^_^",
      commentNum: 6,
      comments: [
        Comment(
          id: 1,
          content: "댓글 1",
          createdAt: DateTime.now(),
          creator: sampleUser1,
          isEdited: false,
        ),
        Comment(
          id: 2,
          content: "댓글 2",
          createdAt: DateTime.now(),
          creator: sampleUser2,
          isEdited: false,
        ),
        Comment(
          id: 3,
          content: "빛나는 커리어 전반에 대한 의심처럼 느껴지는데다, 경기 도중 루틴이 깨지기 때문이다. 상대팀 감독이 투수의 흐름을 끊기 위해 악용할 소지가 다분하다. 슈어저는 조 지라디 필라델피아 필리스 감독과 그라운드 위 설전을 벌이기도 했다. 그런가 하면 타일러 글래스노우(탬파베이 레이스)처럼 그간의 이물질 사용을 시인하며 공인구 변경 및 개선을 요구하는 선수도 있다.",
          createdAt: DateTime.now(),
          creator: sampleUser3,
          isEdited: false,
        ),
        Comment(
          id: 6,
          content: "그럼에도 불구하고 오타니의 얼굴에는 환한 미소가 가득했다. 오타니의 웃음에 전염된 건지, 심판진의 분위기도 화기애애했다. 오타니는 마운드를 내려가면서까지 심판들과 농담을 주고받는 색다른 광경을 연출했다. NBC스포츠는 '전날 슈어저와 달리 오타니는 부정투구 검사를 즐기는 것 같았다. 시종일관 웃음이 가득했다'고 표현했다.",
          createdAt: DateTime.now(),
          creator: sampleUser1,
          isEdited: false,
        ),
        Comment(
          id: 7,
          content: "빅리그 역사에 남을 '이도류'의 해를 보내고 있는 오타니 쇼헤이(LA 에인절스)는 어떨까. 오타니는 최고 160㎞의 직구와 커터, 슬라이더, 포크볼까지 구사한다. 올시즌 3승1패 평균자책점 2점대의 호성적을 거두고 있다. '부정투구' 검사를 피해갈 수는 없다.",
          createdAt: DateTime.now(),
          creator: sampleUser2,
          isEdited: false,
        ),
        Comment(
          id: 8,
          content: "빛나는 커리어 전반에 대한 의심처럼 느껴지는데다, 경기 도중 루틴이 깨지기 때문이다. 상대팀 감독이 투수의 흐름을 끊기 위해 악용할 소지가 다분하다. 슈어저는 조 지라디 필라델피아 필리스 감독과 그라운드 위 설전을 벌이기도 했다. 그런가 하면 타일러 글래스노우(탬파베이 레이스)처럼 그간의 이물질 사용을 시인하며 공인구 변경 및 개선을 요구하는 선수도 있다.",
          createdAt: DateTime.now(),
          creator: sampleUser2,
          isEdited: false,
        )
      ],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    Thread sampleThread2 = Thread(
      id: 1,
      creator: sampleUser2,
      content: "이곳에는 sample user 2가 작성한 자기소개가 들어갑니다. \n ex) Code makes life perfect! 저는 Flutter 개발자입니다 반가워용 ㅎㅎ",
      commentNum: 2,
      comments: [
        Comment(
          id: 4,
          content: "댓글 4",
          createdAt: DateTime.now(),
          creator: sampleUser1,
          isEdited: false,
        ),
        Comment(
          id: 5,
          content: "댓글 5",
          createdAt: DateTime.now(),
          creator: sampleUser2,
          isEdited: false,
        ),
      ],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    Thread sampleThread3 = Thread(
      id: 1,
      creator: sampleUser3,
      content: "이곳에는 sample user 3가 작성한 자기소개가 들어갑니다",
      commentNum: 0,
      comments: [],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    Thread sampleThread4 = Thread(
      id: 1,
      creator: sampleUser2,
      content: "샘플 스레드 샘플 스레드 샘플 스레드 샘플 스레드 샘플 스레드 샘플 스레드 샘플 스레드 샘플 스레드",
      commentNum: 2,
      comments: [
        Comment(
          id: 4,
          content: "댓글 4",
          createdAt: DateTime.now(),
          creator: sampleUser1,
          isEdited: false,
        ),
        Comment(
          id: 5,
          content: "댓글 5",
          createdAt: DateTime.now(),
          creator: sampleUser2,
          isEdited: false,
        ),
      ],
      isEdited: false,
      createdAt: DateTime.now(),
      isNotice: true,
    );

    List<UserProgress> sampleProgresses1 = [
      UserProgress(user: sampleUser1, progress: "k8s deploy infra 구축 & MySQL DB"),
      UserProgress(user: sampleUser2, progress: "카카오 소셜 로그인 iOS FE 개발"),
      UserProgress(user: sampleUser3, progress: "타겟, 사용자의 니즈, 제공 가치, 목표는 최대한 구체화하고 측정가능할 수 있도록 수치화"),
    ];

    List<UserProgress> sampleProgresses2 = [
      UserProgress(user: sampleUser3, progress: "개발자는 먼저 모바일 앱 개발에 대한 경험과 이해가 있는 사람을 리드 개발자로 선임해야 합니다"),
      UserProgress(user: sampleUser4, progress: "디자이너는 모바일 디자인에 대한 이해와 경험이 있어야 합니다"),
      UserProgress(user: sampleUser5, progress: "시나리오 별로 필요한 기능 리스트를 작성합니다"),
      UserProgress(user: sampleUser2, progress: "열심히 하고 있습니다"),
    ];

    List<UserProgress> sampleProgresses3 = [
      UserProgress(user: sampleUser5, progress: "k8s deploy infra 구축 & MySQL DB"),
      UserProgress(user: sampleUser6, progress: "카카오 소셜 로그인 iOS FE 개발"),
      UserProgress(user: sampleUser1, progress: "예산이 넉넉하거나 개발자와 디자이너 소싱이 프로젝트 초반에 가능하다면, 기획자와 개발자, 디자이너가 앱  기획 단계부터 같이 참여하여 진행하는 것을 권장합니다. "),
      UserProgress(user: sampleUser2, progress: "모바일 웹 개발을 진행하는 경우에는 별도로 디자이너와 개발자 외에 퍼블리셔가 필요하기도 합니다."),
    ];

    List<Thread> sampleThreads = [
      sampleThread1,
      sampleThread2,
      sampleThread3,
      sampleThread4,
      sampleThread1,
      sampleThread2,
      sampleThread3,
      sampleThread4,
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
          notice: sampleNotice1,
          progresses: sampleProgresses1,
          threads: sampleThreads,
        ),
        Project(
          id: 2,
          title: "지그재그 카피앱 만들기",
          isRecruiting: false,
          notice: sampleNotice2,
          progresses: sampleProgresses2,
          threads: sampleThreads,
        ),
        Project(
          id: 3,
          title: "제 2의 GUAM 만들기",
          isRecruiting: false,
          notice: sampleNotice3,
          progresses: sampleProgresses3,
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
