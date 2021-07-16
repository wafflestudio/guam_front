import 'package:flutter/material.dart';
import '../../../models/boards/thread_comment_image.dart';
import 'thread_comment_image_container.dart';

class ThreadCommentImages extends StatelessWidget {
  final List<ThreadCommentImage> images;

  ThreadCommentImages({@required this.images});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: images.length < 4 ? images.length : 4,
            crossAxisSpacing: 10,
            childAspectRatio: 1,
          ),
          shrinkWrap: true,
          itemCount: images.length < 4 ? images.length : 4,
          itemBuilder: (_, idx) => ThreadCommentImageContainer(img: images[idx])
      ),
    );
  }
}
