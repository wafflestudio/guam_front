import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'thread_comment_image_container.dart';
import '../../../commons/images_carousel_page.dart';
import '../../../providers/boards/boards.dart';
import '../../../models/thumbnail.dart';

class ThreadCommentImages extends StatelessWidget {
  final List<Thumbnail> images;
  final int maxRenderImgCnt = 4;
  final int creatorId;

  ThreadCommentImages({@required this.images, this.creatorId});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.all(0),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: min(images.length, maxRenderImgCnt),
          crossAxisSpacing: 10,
          childAspectRatio: 1,
        ),
        shrinkWrap: true,
        itemCount: min(images.length, maxRenderImgCnt),
        itemBuilder: (_, idx) => InkWell(
          child: ThreadCommentImageContainer(
            img: images[idx],
            blur: images.length > maxRenderImgCnt && idx == maxRenderImgCnt - 1,
            hiddenImgCnt: images.length - maxRenderImgCnt
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ChangeNotifierProvider.value(
                  value: context.read<Boards>(), // necessary?
                  child: ImagesCarouselPage(
                    thumbnails: [...this.images],
                    initialPage: idx,
                    showImageActions: creatorId != null && context.read<Boards>().isMe(creatorId),
                  ),
                )
              )
            );
          }
        )
      ),
    );
  }
}
