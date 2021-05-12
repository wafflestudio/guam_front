import 'package:flutter/material.dart';
import '../../commons/grey_container.dart';
import '../../models/boards/thread.dart';

class Notice extends StatelessWidget {
  final Thread notice;

  Notice(this.notice);

  @override
  Widget build(BuildContext context) {
    return GreyContainer(
      height: 115,
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '공지',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(notice.content)
        ],
      ),
    );
  }
}
