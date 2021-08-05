import 'package:flutter/material.dart';
import '../../../models/boards/user_task.dart';
import 'task_message.dart';

class Task extends StatefulWidget {
  final UserTask task;

  Task({@required this.task});

  @override
  State<StatefulWidget> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool showAllMsgs;

  @override
  void initState() {
    showAllMsgs = false; // After server code, init done to task.done
    super.initState();
  }

  void toggleShowAllMsgs(bool val) {
    setState(() {
      showAllMsgs = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // adding new
        // list first
        TaskMessage(taskMsg: widget.task.taskMessages.first),
        //if (showAllMsgs) widget.task.taskMessages[1:].map()
        // others
      ],
    );
  }
}
