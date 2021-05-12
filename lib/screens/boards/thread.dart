import 'package:flutter/material.dart';
import '../../commons/profile_thumbnail.dart';
import '../../models/boards/thread.dart' as ThreadModel;

class Thread extends StatelessWidget {
  final ThreadModel.Thread thread;

  Thread(this.thread);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProfileThumbnail(
            profile: thread.creator,
            size: 16,
            showNickname: false,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 9),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      thread.content
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
