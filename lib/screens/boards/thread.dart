import 'package:flutter/material.dart';
import 'package:guam_front/providers/boards/boards.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../commons/profile_thumbnail.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread_page.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;

import 'bottom_modal/function_container.dart';

class Thread extends StatelessWidget {
  final ThreadModel.Thread thread;

  Thread(this.thread);

  @override
  Widget build(BuildContext context) {
    Widget bottomModalContent () => Wrap(
      children: [
        Material(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 10),
            color: Color.fromRGBO(54, 54, 54, 1),
            width: double.infinity,
            child: Column(
              children: [
                FunctionContainer(iconData: Icons.push_pin_outlined, text: "메시지 고정", textColor: Colors.white),
                FunctionContainer(iconData: Icons.edit_outlined, text: "메시지 편집", textColor: Colors.white),
                FunctionContainer(iconData: Icons.delete_outlined, text: "메시지 삭제", iconColor: Colors.red, textColor: Colors.red),
              ],
            ),
          ),
        )
      ],
    );

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
            builder: (_) => bottomModalContent()
          );
        } else {
          showCupertinoModalBottomSheet(
            context: context,
            builder: (_) => bottomModalContent()
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
