import 'package:flutter/material.dart';
import 'package:guam_front/commons/arrow_button.dart';
import 'package:guam_front/screens/tutorial/tutorial_image.dart';

class TutorialPage extends StatelessWidget {
  final String title;
  final String description_1;
  final String description_2;
  final String imagePath;
  final bool isImageTop;
  final Function goToNextPage;
  final Function goToPreviousPage;

  TutorialPage({this.title, this.description_1, this.description_2, this.imagePath, this.isImageTop, this.goToNextPage, this.goToPreviousPage});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backgrounds/projects-bg-2.png"),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.7), BlendMode.dstATop),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: Column(
            children: [
              if (isImageTop) TutorialImage(imagePath, isImageTop),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: FittedBox(child: Text(title, style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold))),
              ),
              FittedBox(child: Text(description_1, style: TextStyle(fontSize: 20))),
              FittedBox(child: Text(description_2, style: TextStyle(fontSize: 20))),
              Row(
                children: [
                  ArrowButton(onTap: this.goToPreviousPage, active: true, isRightArrow: false),
                  ArrowButton(onTap: this.goToNextPage, active: true),
                ],
              ),
              if (!isImageTop) TutorialImage(imagePath, isImageTop),
            ],
          ),
        )
      )
    );
  }
}
