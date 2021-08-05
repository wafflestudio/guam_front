import 'package:flutter/material.dart';
import '../../../models/boards/task_msg.dart';

class TaskMessage extends StatefulWidget {
  final TaskMsg taskMsg;

  TaskMessage({@required this.taskMsg});

  @override
  State<StatefulWidget> createState() => _TaskMessageState();
}

class _TaskMessageState extends State<TaskMessage> {
  bool done;

  @override
  void initState() {
    done = false; // After server code, init done to task.done
    super.initState();
  }

  void toggleDone(bool val) {
    // request toggle done to server
    setState(() {
      done = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      // constraints: BoxConstraints(
      //   minHeight: 40,
      // ),
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
                Checkbox(
                    value: done,
                    onChanged: (val) => toggleDone(val)
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
