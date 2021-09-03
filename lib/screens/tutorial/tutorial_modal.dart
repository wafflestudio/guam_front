import 'package:flutter/material.dart';
import 'package:guam_front/screens/tutorial/tutorial_page.dart';

class TutorialModal extends StatefulWidget {
  final Function onExit;

  TutorialModal({this.onExit});

  @override
  _TutorialModalState createState() => _TutorialModalState();
}

class _TutorialModalState extends State<TutorialModal> {
  int _currentPage = 1;
  void goToNextPage() => setState(() {if (_currentPage < 6) _currentPage++;});
  void goToPreviousPage() => setState(() {if (_currentPage > 1) _currentPage--;});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 60),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage == 1)
              TutorialPage(
                title: "프로젝트 참여",
                description_1: "현재 모집중인 프로젝트",
                description_2: "손쉽게 찾을 수 있어요",
                imagePath: "assets/tutorial/tutorial_project_tab.png",
                isImageTop: false,
                page: _currentPage,
                goToNextPage: goToNextPage
              ),
            if (_currentPage == 2)
              TutorialPage(
                title: "프로젝트 검색",
                description_1: "기술스택, 포지션, 기간",
                description_2: "프로젝트를 찾을 수 있어요",
                imagePath: "assets/tutorial/tutorial_project_search.png",
                isImageTop: false,
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 3)
              TutorialPage(
                title: "프로젝트 생성",
                description_1: "기술 스택과 인원을 고려하여",
                description_2: "프로젝트를 만들 수 있어요",
                imagePath: "assets/tutorial/tutorial_project_create.png",
                isImageTop: true,
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 4)
              TutorialPage(
                title: "작업실",
                description_1: "작업실에서 협업에 필요한",
                description_2: "다양한 기능을 만나보세요",
                imagePath: "assets/tutorial/tutorial_board.png",
                isImageTop: false,
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 5)
              TutorialPage(
                title: "스레드",
                description_1: "팀원들과 소통이 필요한 경우",
                description_2: "스레드에 글을 남길 수 있어요",
                imagePath: "assets/tutorial/tutorial_thread.png",
                isImageTop: true,
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 6)
              TutorialPage(
                title: "프로필",
                description_1: "프로필에서 자신이 사용가능한",
                description_2: "기술 스택을 소개할 수 있어요",
                imagePath: "assets/tutorial/tutorial_profile_tab.png",
                isImageTop: false,
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
                onExit: widget.onExit,
              ),
          ]
        )
    );
  }
}
