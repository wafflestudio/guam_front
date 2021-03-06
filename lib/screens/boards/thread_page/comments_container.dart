import 'package:flutter/material.dart';
import '../../../models/boards/comment.dart' as CommentModel;
import 'comment.dart';
import '../iconTitle.dart';

class CommentsContainer extends StatelessWidget {
  final Function switchToEditMode;
  final Function deleteComment;
  final List<CommentModel.Comment> comments;
  final CommentModel.Comment editTargetComment;

  final Function fetchFullThread; // needed for comments image carousel deletion callback

  CommentsContainer({@required this.comments, @required this.switchToEditMode,
    @required this.deleteComment, @required this.editTargetComment, @required this.fetchFullThread});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          iconTitle(
              icon: Icons.message_outlined,
              title: "${comments.length}κ°μ λκΈ"
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (_, idx) => Comment(
              comment: comments[idx],
              switchToEditMode: switchToEditMode,
              deleteComment: deleteComment,
              isEditTarget: editTargetComment == comments[idx],
              fetchFullThread: fetchFullThread,
            ),
          )
        ],
      ),
    );
  }
}
