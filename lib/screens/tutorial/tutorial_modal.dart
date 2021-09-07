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
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (_currentPage == 1)
              TutorialPage(
                imagePath: "assets/tutorial/tutorial-1.png",
                page: _currentPage,
                goToNextPage: goToNextPage
              ),
            if (_currentPage == 2)
              TutorialPage(
                imagePath: "assets/tutorial/tutorial-2.png",
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 3)
              TutorialPage(
                imagePath: "assets/tutorial/tutorial-3.png",
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 4)
              TutorialPage(
                imagePath: "assets/tutorial/tutorial-4.png",
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 5)
              TutorialPage(
                imagePath: "assets/tutorial/tutorial-5.png",
                page: _currentPage,
                goToNextPage: goToNextPage,
                goToPreviousPage: goToPreviousPage,
              ),
            if (_currentPage == 6)
              TutorialPage(
                imagePath: "assets/tutorial/tutorial-6.png",
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
