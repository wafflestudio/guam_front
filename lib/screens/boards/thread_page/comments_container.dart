import 'package:flutter/material.dart';
import '../../../models/boards/comment.dart' as CommentModel;
import 'comment.dart';
import '../iconTitle.dart';

class CommentsContainer extends StatelessWidget {
  final Function deleteComment;
  final List<CommentModel.Comment> comments;

  CommentsContainer({@required this.comments, @required this.deleteComment});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      child: Column(
        children: [
          iconTitle(
              icon: Icons.message_outlined,
              title: "${comments.length}개의 답글"
          ),
          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: comments.length,
            itemBuilder: (_, idx) => Comment(comment: comments[idx], deleteComment: deleteComment),
          )
        ],
      ),
    );
  }
}
