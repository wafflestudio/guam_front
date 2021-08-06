import 'package:flutter/material.dart';
import '../../../models/boards/task_msg.dart';
import '../../../providers/boards/boards.dart';
import 'package:provider/provider.dart';

class TaskMessage extends StatefulWidget {
  final TaskMsg taskMsg;
  final bool isMyTaskMsg;

  TaskMessage({@required this.taskMsg, @required this.isMyTaskMsg});

  @override
  State<StatefulWidget> createState() => _TaskMessageState();
}

class _TaskMessageState extends State<TaskMessage> {
  bool done;

  Future updateTaskMsgState(bool done) async {
    await context.read<Boards>().updateTaskMsg(
        taskMsgId: widget.taskMsg.id,
        body: {
          "status": done ? "DONE" : "ONGOING"
        }
    );
  }

  void toggleDone(bool val) {
    setState(() {
      done = val;
    });
    updateTaskMsgState(val);
  }

  @override
  Widget build(BuildContext context) {
    done = widget.taskMsg.status == "DONE";

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: 40,
                    minHeight: 40
                  ),
                  child: Checkbox(
                      value: done,
                      onChanged: widget.isMyTaskMsg
                          ? (val) => toggleDone(val)
                          : null
                  ),
                ),
                Expanded(
                  child: Text(
                    widget.taskMsg.msg,
                    style: TextStyle(fontSize: 14),
                  )
                ),
              ],
            ),
          )
      ),
    );
  }
}
