import 'package:flutter/material.dart';
import 'package:guam_front/commons/arrow_button.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/screens/tutorial/tutorial_image.dart';
import 'exit_tutorial_button.dart';

class TutorialPage extends StatelessWidget {
  final String title;
  final String description_1;
  final String description_2;
  final String imagePath;
  final bool isImageTop;
  final int page;
  final Function goToNextPage;
  final Function goToPreviousPage;
  final Function onExit;

  TutorialPage({this.title, this.description_1, this.description_2, this.imagePath,
    this.isImageTop, this.goToNextPage, this.goToPreviousPage, this.page, this.onExit});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.white,
          image: DecorationImage(
            image: AssetImage(
              isImageTop
                ? "assets/tutorial/tutorial_bg_2.png"
                : "assets/tutorial/tutorial_bg_1.png"
            ),
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(Colors.white.withOpacity(0.7), BlendMode.dstATop),
          ),
        ),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.75,
          child: Padding(
            padding: EdgeInsets.only(top: 30),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ArrowButton(onTap: this.goToPreviousPage, active: page != 1, isRightArrow: false),
                    Column(
                      children: [
                        if (isImageTop) TutorialImage(imagePath: imagePath, isImageTop: isImageTop),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Column(
                            children: [
                              // Title
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: FittedBox(
                                  child: Text(title, style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold))
                                ),
                              ),
                              // Description two lines
                              FittedBox(child: Text(description_1, style: TextStyle(fontSize: 15))),
                              FittedBox(child: Text(description_2, style: TextStyle(fontSize: 15))),
                            ],
                          ),
                        ),
                        if (!isImageTop) TutorialImage(imagePath: imagePath, isImageTop: isImageTop, page: page),
                      ],
                    ),
                    page != 6
                        ? ArrowButton(onTap: this.goToNextPage, active: true)
                        : ExitTutorialButton(onExit: onExit),
                  ],
                ),
                // Spacer(),
                // ProjectStatus(totalPage: 6, currentPage: page)
              ],
            ),
          ),
        )
      )
    );
  }
}
