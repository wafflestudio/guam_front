import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../../commons/circular_border_container.dart';
import '../../../models/boards/thread.dart';
import '../../../commons/profile_thumbnail.dart';
import 'thread_comment_images.dart';

class ThreadContainer extends StatelessWidget {
  final Thread thread;

  ThreadContainer({@required this.thread});

  @override
  Widget build(BuildContext context) {
    return CircularBorderContainer(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                ProfileThumbnail(
                  profile: thread.creator,
                  showNickname: true,
                  radius: 12,
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Text(
                    DateFormat("M월 d일 hh:mm").format(thread.createdAt).toString(),
                    style: TextStyle(
                      fontSize: 10,
                      color: HexColor("#818181"),
                    )
                )
              ],
            ),
          ),
          if (thread.content != null && thread.content != "") Padding(
            padding: EdgeInsets.only(bottom: thread.threadImages.isNotEmpty ? 10 : 0),
            child: Text(thread.content),
          ),
          if (thread.threadImages.isNotEmpty) ThreadCommentImages(images: thread.threadImages),
        ],
      ),
      contentColor: Color.fromRGBO(246, 228, 173, 0.6),
    );
  }
}
