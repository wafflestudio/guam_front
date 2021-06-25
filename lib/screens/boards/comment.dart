import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../commons/profile_thumbnail.dart';
import 'package:intl/intl.dart';
import '../../models/boards/comment.dart' as CommentModel;

class Comment extends StatelessWidget {
  final CommentModel.Comment comment;

  Comment(this.comment);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text(comment.content)
        ],
      )
    );
  }
}
