import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../commons/profile_thumbnail.dart';
import '../../models/boards/thread.dart' as ThreadModel;

class Thread extends StatelessWidget {
  final ThreadModel.Thread thread;

  Thread(this.thread);

  @override
  Widget build(BuildContext context) {
    return Container(
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
          )
        ],
      ),
    );
  }
}
