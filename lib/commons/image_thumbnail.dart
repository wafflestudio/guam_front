import 'package:flutter/material.dart';

class ImageThumbnail extends StatelessWidget {
  final Widget image;
  final double height;
  final double width;

  ImageThumbnail({@required this.image, @required this.height, @required this.width});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: image,
      ),
    );
  }
}
