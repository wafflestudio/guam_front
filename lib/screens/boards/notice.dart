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
      padding: EdgeInsets.only(bottom: 12),
      child: GreyContainer(
        header: Text(
          '공지',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Thread(notice),
          ],
        ),
      )
    );
  }
}
