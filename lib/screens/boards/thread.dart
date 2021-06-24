import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../commons/profile_thumbnail.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread_page.dart';

class Thread extends StatelessWidget {
  final ThreadModel.Thread thread;

  Thread(this.thread);

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
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => ThreadPage(thread)));
        },
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
                            if (thread.commentNum != 0) Text(
                              "댓글 +${thread.commentNum}",
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
                )
            )
          ],
        ),
      )
    );
  }
}
