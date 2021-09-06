import 'package:flutter/material.dart';

class TutorialImage extends StatelessWidget {
  final String imagePath;
  final bool isImageTop;
  final int page;

  TutorialImage({this.imagePath, this.isImageTop, this.page});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: Image(
        image: AssetImage(imagePath),
        fit: BoxFit.cover
      )
    );
  }
}
