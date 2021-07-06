import 'package:flutter/material.dart';
import '../../models/boards/user_task.dart';

class Task extends StatelessWidget {
  final UserTask task;

  Task({@required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 40,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task.task
            ),
            // check button here!
          ],
        ),
      ),
    );
  }
}
