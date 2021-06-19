import 'package:flutter/material.dart';
import '../../commons/grey_container.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread.dart';

class Notice extends StatelessWidget {
  final ThreadModel.Thread notice;

  Notice(this.notice);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: GreyContainer(
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
        content: Thread(notice),
      )
    );
  }
}
