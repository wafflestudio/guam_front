import 'package:flutter/material.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/screens/tutorial/tutorial_page.dart';

class TutorialApp extends StatefulWidget {
  @override
  _TutorialAppState createState() => _TutorialAppState();
}

class _TutorialAppState extends State<TutorialApp> {
  int _currentPage = 1;
  void goToNextPage() => setState(() {if (_currentPage < 6) _currentPage++;});
  void goToPreviousPage() => setState(() {if (_currentPage > 1) _currentPage--;});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 50),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage == 1)
              TutorialPage(
                title: "프로젝트 참여",
                description_1: "현재 모집중인 프로젝트를",
                description_2: "손쉽게 찾아볼 수 있어요",
                imagePath: "assets/backgrounds/profile-bg-1.png",
                isImageTop: true,
                goToNextPage: goToNextPage
              ),
            if (_currentPage == 2)
              TutorialPage(
                title: "다양한 검색 기능",
                description_1: "원하는 기술 스택, 포지션, 기간",
                description_2: "딱 맞는 프로젝트를 찾을 수 있어요",
                imagePath: "assets/images/project-thumbnail-default.png",
                isImageTop: true,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 3)
              TutorialPage(
                title: "프로젝트 생성",
                description_1: "기술 스택과 인원을 고려하여",
                description_2: "프로젝트를 만들 수 있어요",
                imagePath: "assets/images/project-thumbnail-default.png",
                isImageTop: true,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 4)
              TutorialPage(
                title: "작업실",
                description_1: "작업실에서 협업에 필요한",
                description_2: "다양한 기능을 만나보세요",
                imagePath: "assets/images/project-thumbnail-default.png",
                isImageTop: true,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 5)
              TutorialPage(
                title: "스레드",
                description_1: "팀원들과 소통이 필요한 경우",
                description_2: "스레드에 글을 남길 수 있어요",
                imagePath: "assets/images/project-thumbnail-default.png",
                isImageTop: true,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 6)
              TutorialPage(
                title: "프로필",
                description_1: "프로필에서 자신이 사용가능한",
                description_2: "기술 스택을 소개할 수 있어요",
                imagePath: "assets/images/project-thumbnail-default.png",
                isImageTop: true,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            ProjectStatus(totalPage: 6, currentPage: _currentPage)
          ]
        )
    );
  }
}
