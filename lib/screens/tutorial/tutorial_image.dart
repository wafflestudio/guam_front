import 'package:flutter/material.dart';

class TutorialImage extends StatelessWidget {
  final String imagePath;
  final bool isImageTop;
  final int page;

  TutorialImage({this.imagePath, this.isImageTop, this.page});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: page == 1 // 성민님이 수정하신 1번째 예시 사진 크기가 약간 큼.
        ? MediaQuery.of(context).size.height * 0.4
        : MediaQuery.of(context).size.height * 0.45,
      child: Image(image: AssetImage(imagePath), fit: BoxFit.cover)
    );
  }
}
