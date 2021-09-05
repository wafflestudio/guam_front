import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../commons/circular_border_container.dart';
import '../../../models/boards/thread.dart';
import '../../../commons/profile_thumbnail.dart';
import 'thread_comment_images.dart';
import '../buttons/join_thread_buttons.dart';
import '../../../providers/boards/boards.dart';
import '../buttons/accepted_declined_thread_button.dart';

class ThreadContainer extends StatelessWidget {
  final Thread thread;

  ThreadContainer({@required this.thread});

  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.read<Boards>();

    final isJoinThread = thread.type == "JOIN";
    final isAcceptedThread = thread.type == "ACCEPTED";
    final isDeclinedThread = thread.type == "DECLINED";

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
                  activateRedirectOnTap: true,
                ),
                Padding(padding: EdgeInsets.only(right: 10)),
                Text(
                    DateFormat("M월 d일 kk:mm").format(thread.createdAt).toString(),
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
          // 반려되면 스레드가 바로 삭제되어 버려, decline 시 navigator pop하는 로직을 thread_page에는 넣어야 되는데 아직 어려워서 생략
          // if (isJoinThread) JoinThreadButtons(
          //   userId: thread.creator.id,
          //   enabled: boardsProvider.leaderIsMe(),
          // ),
          if (isAcceptedThread || isDeclinedThread) AcceptedDeclinedThreadButton(
              accepted: isAcceptedThread
          )
        ],
      ),
      contentColor: Color.fromRGBO(246, 228, 173, 0.6),
    );
  }
}
