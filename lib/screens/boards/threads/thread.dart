import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import '../../../providers/boards/boards.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../../../commons/profile_thumbnail.dart';
import '../../../models/boards/thread.dart' as ThreadModel;
import '../thread_page/thread_page.dart';
import '../thread_page/thread_comment_images.dart';
import '../../../commons/bottom_modal/bottom_modal_content.dart';
import '../accept_decline_button.dart';
import '../waiting_button.dart';

class Thread extends StatelessWidget {
  final ThreadModel.Thread thread;
  final Function switchToEditMode;
  final bool isEditTarget;

  Thread(this.thread, {this.switchToEditMode, this.isEditTarget});

  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.read<Boards>();

    print(boardsProvider.currentBoard.userStates);


    final isGuestThread = boardsProvider.currentBoard.userStates[thread.creator.id] == "GUEST";
    final isDeclinedThread = boardsProvider.currentBoard.userStates[thread.creator.id] == "DECLINED";

    final showAcceptDeclineButton = ( isGuestThread && boardsProvider.leaderIsMe() ) || isDeclinedThread;
    final showWaitingButton = isGuestThread && !boardsProvider.leaderIsMe();

    Future setNotice() async {
      await boardsProvider.setNotice(thread.id).then((res) {
        if (res) Navigator.of(context).pop();
      });
    }

    Future deleteThread() async {
      await boardsProvider.deleteThread(thread.id).then((res) {
        if (res) Navigator.of(context).pop();
      });
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return ChangeNotifierProvider.value(
              value: boardsProvider,
              child: ThreadPage(
                thread: thread,
                comments: boardsProvider.fetchFullThread(thread.id)
              ),
            );
          })
        );
      },
      onLongPress: () {
        if (context.read<Authenticate>().me.id == thread.creator.id) {
          if (Platform.isAndroid) {
            showMaterialModalBottomSheet(
                context: context,
                builder: (_) => BottomModalContent(
                  setText: "스레드 고정",
                  editText: "스레드 편집",
                  deleteText: "스레드 삭제",
                  deleteDetailText: "스레드를 삭제하시겠습니까?",
                  setFunc: setNotice,
                  editFunc: () {
                    switchToEditMode(editTargetThread: thread);
                    Navigator.of(context).pop();
                  },
                  deleteFunc: deleteThread,
                  deleteRequireConfirm: true,
                )
            );
          } else {
            showCupertinoModalBottomSheet(
                context: context,
                builder: (_) => BottomModalContent(
                  setText: "스레드 고정",
                  editText: "스레드 편집",
                  deleteText: "스레드 삭제",
                  deleteDetailText: "스레드를 삭제하시겠습니까?",
                  setFunc: setNotice,
                  editFunc: () {
                    switchToEditMode(editTargetThread: thread);
                    Navigator.of(context).pop();
                  },
                  deleteFunc: deleteThread,
                  deleteRequireConfirm: true,
                )
            );
          }
        }
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 7),
        decoration: BoxDecoration(
          color: isEditTarget ? Color.fromRGBO(255, 235, 148, 0.5) : null,
          border: Border(
            bottom: BorderSide(
              color: Color.fromRGBO(151, 151, 151, 0.2),
              width: 1.5,
            )
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileThumbnail(
              profile: thread.creator,
              radius: 12,
              showNickname: false,
              activateRedirectOnTap: true,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (thread.content != null) Padding(
                      child: Text(
                        thread.content,
                        style: TextStyle(fontSize: 12),
                      ),
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                    if (thread.threadImages.isNotEmpty) ThreadCommentImages(
                      threadId: thread.id,
                      creatorId: thread.creator.id,
                      images: thread.threadImages
                    ),
                    Row(
                      children: [
                        if (thread.commentSize != 0) Text(
                          "댓글 +${thread.commentSize}",
                          style: TextStyle(fontSize: 12),
                        ),
                        Spacer(),
                        Text(
                          DateFormat("M월 d일 kk:mm").format(thread.createdAt).toString(),
                          style: TextStyle(
                            fontSize: 10,
                            color: HexColor("#818181"),
                          ),
                        )
                      ],
                    ),
                    // show accept decline button if condition met & is leader
                    if (showAcceptDeclineButton) AcceptDeclineButton(
                      userId: thread.creator.id,
                      userState: boardsProvider.currentBoard.userStates[thread.creator.id],
                      enabled: boardsProvider.currentBoard.userStates[thread.creator.id] == "GUEST"
                    ),
                    if (showWaitingButton) WaitingButton()
                  ],
                ),
              ),
            )
          ]
        )
      )
    );
  }
}
