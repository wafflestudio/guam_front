import 'package:flutter/material.dart';
import 'package:guam_front/screens/my_page/another_profile/another_profile_app.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'dart:io' show Platform;
import '../../../commons/profile_thumbnail.dart';
import '../../../models/boards/comment.dart' as CommentModel;
import '../../../providers/boards/boards.dart';
import '../../../commons/bottom_modal/bottom_modal_content.dart';
import 'thread_comment_images.dart';

class Comment extends StatelessWidget {
  final CommentModel.Comment comment;
  final Function switchToEditMode;
  final Function deleteComment;
  final bool isEditTarget;

  final Function fetchFullThread; // needed for comments image carousel deletion callback

  Comment({@required this.comment, @required this.switchToEditMode,
    @required this.deleteComment, @required this.isEditTarget, @required this.fetchFullThread});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        if (context.read<Boards>().isMe(comment.creator.id)) {
          if (Platform.isAndroid) {
            showMaterialModalBottomSheet(
              context: context,
              builder: (_) => BottomModalContent(
                  editText: "메시지 편집",
                  deleteText: "메시지 삭제",
                  editFunc: () {
                    switchToEditMode(editTargetComment: comment);
                    Navigator.of(context).pop(); // pops Modal Bottom Content Widget
                  },
                  deleteFunc: () => deleteComment(comment.id).then((val) {
                    if (val) Navigator.of(context).pop();
                  })
                )
            );
          } else {
            showCupertinoModalBottomSheet(
                context: context,
                builder: (_) => BottomModalContent(
                    editText: "메시지 편집",
                    deleteText: "메시지 삭제",
                    editFunc: () {
                      switchToEditMode(editTargetComment: comment);
                      Navigator.of(context).pop(); // pops Modal Bottom Content Widget
                    },
                    deleteFunc: () => deleteComment(comment.id).then((val) {
                      if (val) Navigator.of(context).pop();
                    })
                )
            );
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: isEditTarget ? Color.fromRGBO(255, 223, 82, 1) : null,
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(151, 151, 151, 0.2),
              width: 1.5,
            )
          ),
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
                  activateRedirectOnTap: true,
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                              AnotherProfile(comment.creator.id))),
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
            if (comment.commentImages.isNotEmpty) ThreadCommentImages(
              commentId: comment.id,
              creatorId: comment.creator.id,
              images: comment.commentImages,
              fetchFullThread: fetchFullThread,
            )
          ],
        )
      ),
    );
  }
}
