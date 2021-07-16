import 'package:flutter/material.dart';
import 'package:guam_front/providers/boards/boards.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../commons/profile_thumbnail.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread_page/thread_page.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'bottom_modal/bottom_modal_content.dart';

class Thread extends StatelessWidget {
  final ThreadModel.Thread thread;

  Thread(this.thread);

  @override
  Widget build(BuildContext context) {
    print(thread.threadImages);

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) {
            return ThreadPage(
              boardsProvider: context.read<Boards>(),
              thread: thread,
            );
          })
        );
      },
      onLongPress: () {
        if (Platform.isAndroid) {
          showMaterialModalBottomSheet(
            context: context,
            builder: (_) => BottomModalContent()
          );
        } else {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (_) => BottomModalContent()
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
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProfileThumbnail(
              profile: thread.creator,
              radius: 12,
              showNickname: false,
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 9),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      thread.content,
                      style: TextStyle(fontSize: 12),
                    ),
                    // Thread Images Max Grid: 4
                    if (thread.threadImages.isNotEmpty) GridView.count(
                      shrinkWrap: true,
                      crossAxisCount: thread.threadImages.length < 4 ? thread.threadImages.length : 4,
                      childAspectRatio: 1,
                      children: [
                        Container(
                          color: Colors.red,
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 6),
                      child: Row(
                        children: [
                          if (thread.commentSize != 0) Text(
                            "댓글 +${thread.commentSize}",
                            style: TextStyle(
                                fontSize: 12
                            ),
                          ),
                          Spacer(),
                          Text(
                            DateFormat("M월 d일 hh:mm").format(thread.createdAt).toString(),
                            style: TextStyle(
                              fontSize: 10,
                              color: HexColor("#818181"),
                            ),
                          )
                        ],
                      ),
                    )
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
