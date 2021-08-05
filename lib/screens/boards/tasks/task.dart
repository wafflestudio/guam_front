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
    showAllMsgs = false;
    super.initState();
  }

  void toggleShowAllMsgs() {
    setState(() {
      showAllMsgs = !showAllMsgs;
    });
  }

  Widget taskDropdownButton() => InkWell(
    child: taskActionButton(showAllMsgs ? Icons.expand_less : Icons.expand_more),
    onTap: toggleShowAllMsgs,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (widget.task.taskMessages != null) Column(
          children: [
            // adding new
            // list first
            if (widget.task.taskMessages.isNotEmpty) TaskMessage(taskMsg: widget.task.taskMessages.first),
            if (showAllMsgs && widget.task.taskMessages.length > 1) Column(
              children: widget.task.taskMessages
                  .sublist(1)
                  .map((e) => TaskMessage(taskMsg: e))
                  .toList(),
            ),
            // others
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            taskDropdownButton(),
            Padding(padding: EdgeInsets.only(right: 10)),
            taskAddButton(),
          ],
        )
      ],
    );
  }
}

Widget taskActionButton(IconData icon) => Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Colors.white
    ),
    child: Icon(icon)
);

Widget taskAddButton() => InkWell(
  child: taskActionButton(Icons.add),
  onTap: () {},
);
