import 'package:flutter/material.dart';
import '../../models/boards/user_progress.dart';
import '../../commons/grey_container.dart';
import 'progress.dart';

class Progresses extends StatelessWidget {
  final List<UserProgress> progresses;

  Progresses(this.progresses);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: GreyContainer(
        //height: 210,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '진행 상황',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Column(
              children: [...progresses.map((e) => Progress(e))],
            )
          ],
        ),
      )
    );
  }
}
