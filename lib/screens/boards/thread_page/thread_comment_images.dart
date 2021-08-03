import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'thread_comment_image_container.dart';
import '../../../commons/images_carousel_page.dart';
import '../../../providers/boards/boards.dart';
import '../../../models/thumbnail.dart';

class ThreadCommentImages extends StatelessWidget {
  final int maxRenderImgCnt = 4;
  final List<Thumbnail> images;
  final int creatorId;
  // IMPORTANT: Only one of fields below should be passed as parameter
  final int threadId;
  final int commentId;

  ThreadCommentImages({@required this.images, this.threadId, this.commentId, this.creatorId});

  @override
  Widget build(BuildContext context) {
    Future deleteThreadImage({@required int imageId}) async {
      await context.read<Boards>().deleteThreadImage(
        threadId: threadId,
        imageId: imageId,
      ).then((successful) {
        if (successful) {
          print("deleted thread image");
        }
      });
    }

    Future deleteCommentImage({@required int imageId}) async {
      await context.read<Boards>().deleteCommentImage(
        commentId: commentId,
        imageId: imageId,
      ).then((successful) {
        if (successful) {
          print("deleted comment image");
        }
      });
    }

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
                    deleteFunc: threadId != null ? deleteThreadImage
                        : commentId != null ? deleteCommentImage
                        : null,
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
