import 'package:flutter/material.dart';
import 'package:guam_front/commons/arrow_button.dart';
import 'exit_tutorial_button.dart';

class TutorialPage extends StatelessWidget {
  final String imagePath;
  final int page;
  final Function goToNextPage;
  final Function goToPreviousPage;
  final Function onExit;

  TutorialPage({this.imagePath, this.goToNextPage, this.goToPreviousPage, this.page, this.onExit});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            child: Image(image: AssetImage(imagePath))
          ),
          Positioned(
            left: -10,
            child: ArrowButton(
              onTap: this.goToPreviousPage,
              active: page != 1,
              isRightArrow: false,
            )
          ),
          Positioned(
            right: -10,
            child: page != 6
              ? ArrowButton(onTap: this.goToNextPage, active: true)
              : ExitTutorialButton(onExit: onExit),
          ),
        ],
      )
    );
  }
}
