import 'dart:math';

import 'package:flutter/material.dart';
import '../../../models/boards/thread_comment_image.dart';
import 'thread_comment_image_container.dart';

class ThreadCommentImages extends StatelessWidget {
  final List<ThreadCommentImage> images;
  final int maxRenderImgCnt = 4;

  ThreadCommentImages({@required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GridView.builder(
          padding: EdgeInsets.all(0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: min(images.length, maxRenderImgCnt),
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          shrinkWrap: true,
          itemCount: min(images.length, maxRenderImgCnt),
          itemBuilder: (_, idx) => ThreadCommentImageContainer(
            img: images[idx],
            blur: images.length > maxRenderImgCnt && idx == maxRenderImgCnt - 1,
            hiddenImgCnt: images.length - maxRenderImgCnt
          )
      ),
    );
  }
}
