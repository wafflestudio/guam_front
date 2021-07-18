import 'package:flutter/material.dart';
import 'package:guam_front/screens/boards/thread_page/thread_comment_images.dart';
import 'package:guam_front/screens/boards/thread_page/thread_page.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../commons/profile_thumbnail.dart';
import 'package:intl/intl.dart';
import '../../../models/boards/comment.dart' as CommentModel;
import 'dart:io' show Platform;
import '../bottom_modal/bottom_modal_content.dart';
import '../../../providers/boards/boards.dart';

class Comment extends StatelessWidget {
  final CommentModel.Comment comment;
  final Function deleteComment;

  Comment({@required this.comment, @required this.deleteComment});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (Platform.isAndroid) {
          showMaterialModalBottomSheet(
              context: context,
              builder: (_) => BottomModalContent(
                deleteFunc: () => deleteComment(comment.id).then((val) {
                  if (val) Navigator.of(context).pop();
                })
              )
          );
        } else {
          showCupertinoModalBottomSheet(
              context: context,
              builder: (_) => BottomModalContent(
                  deleteFunc: () => deleteComment(comment.id).then((val) {
                    if (val) Navigator.of(context).pop();
                  })
              )
          );
        }
      },
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 7),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
                    color: Color.fromRGBO(151, 151, 151, 0.2),
                    width: 1.5,
                  )
              )
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    ProfileThumbnail(
                      profile: comment.creator,
                      showNickname: true,
                      radius: 12,
                    ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    Text(
                        DateFormat("M월 d일 hh:mm").format(comment.createdAt).toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: HexColor("#818181"),
                        )
                    )
                  ],
                ),
              ),
              if (comment.content != null && comment.content != "") Padding(
                padding: EdgeInsets.only(bottom: comment.commentImages.isNotEmpty ? 10 : 0),
                child: Text(comment.content),
              ),
              if (comment.commentImages.isNotEmpty) ThreadCommentImages(images: comment.commentImages)
            ],
          )
      ),
    );
  }
}
