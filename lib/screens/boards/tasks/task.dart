import 'package:flutter/material.dart';
import '../../../models/boards/user_task.dart';
import 'task_message.dart';
import 'package:provider/provider.dart';
import '../../../providers/boards/boards.dart';
import 'empty_task_message.dart';

class Task extends StatefulWidget {
  final UserTask task;

  Task({@required this.task});

  @override
  State<StatefulWidget> createState() => _TaskState();
}

class _TaskState extends State<Task> {
  bool addingNewMsg;
  bool showAllMsgs;

  @override
  void initState() {
    addingNewMsg = false;
    showAllMsgs = false;
    super.initState();
  }

  void toggleAddingNewMsg() => setState(() { addingNewMsg = !addingNewMsg; });

  void toggleShowAllMsgs() => setState(() { showAllMsgs = !showAllMsgs; });

  Widget taskAddButton() => InkWell(
    child: taskActionButton(addingNewMsg ? Icons.remove : Icons.add),
    onTap: toggleAddingNewMsg,
  );

  Widget taskDropdownButton() => InkWell(
    child: taskActionButton(showAllMsgs ? Icons.expand_less : Icons.expand_more),
    onTap: toggleShowAllMsgs,
  );

  @override
  Widget build(BuildContext context) {
    final bool isMyTask = context.read<Boards>().isMe(widget.task.user.id);

    Future createTaskMsg({Map<String, String> fields, dynamic files}) async {
      bool res = await context.read<Boards>().createTaskMsg(
        taskId: widget.task.id,
        body: {
          "msg": fields["content"],
          "status": "ONGOING",
        },
      ).then((successful) {
        if (successful) toggleAddingNewMsg();
        return successful;
      });

      return res;
    }

    return Column(
      children: [
        if (widget.task.taskMessages != null) Column(
          children: [
            if (addingNewMsg && isMyTask) EmptyTaskMessage(createTaskMsg: createTaskMsg),
            if (widget.task.taskMessages.isNotEmpty) TaskMessage(
              taskMsg: widget.task.taskMessages.first,
              isMyTaskMsg: isMyTask
            ),
            if (showAllMsgs && widget.task.taskMessages.length > 1) Column(
              children: widget.task.taskMessages
                  .sublist(1)
                  .map((e) => TaskMessage(taskMsg: e, isMyTaskMsg: isMyTask))
                  .toList(),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            taskDropdownButton(),
            if (isMyTask) Row(
              children: [
                Padding(padding: EdgeInsets.only(right: 10)),
                taskAddButton(),
              ],
            ),
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
