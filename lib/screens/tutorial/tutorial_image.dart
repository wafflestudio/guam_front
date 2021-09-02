import 'package:flutter/material.dart';

class TutorialImage extends StatelessWidget {
  final String imagePath;
  final bool isImageTop;

  TutorialImage(this.imagePath, this.isImageTop);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7), BlendMode.dstATop,
            ),
          ),
        )
      )
    );
  }
}
