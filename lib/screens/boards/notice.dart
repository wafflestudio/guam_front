import 'package:flutter/material.dart';
import '../../commons/circular_border_container.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import '../../commons/profile_thumbnail.dart';
import 'thread.dart';

class Notice extends StatelessWidget {
  final ThreadModel.Thread notice;

  Notice(this.notice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: CircularBorderContainer(
        header: Row(
          children: [
            Icon(Icons.notifications),
            Padding(padding: EdgeInsets.only(right: 8)),
            Text(
              '공지',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        content: Container(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ProfileThumbnail(
                profile: notice.creator,
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
                          notice.content,
                          style: TextStyle(fontSize: 12),
                        )
                      ],
                    ),
                  )
              )
            ],
          ),
        ),
      )
    );
  }
}


