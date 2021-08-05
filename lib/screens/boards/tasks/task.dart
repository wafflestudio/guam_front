import 'package:flutter/material.dart';
import '../../../models/boards/user_task.dart';

class Task extends StatefulWidget {
  final UserTask task;

  Task({@required this.task});

  @override
  State<StatefulWidget> createState() => _TaskState();
}

class _TaskState extends State<Task> {
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
      width: double.infinity,
      height: 40,
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
                // Text(
                //   widget.task.task,
                //   style: TextStyle(fontSize: 14),
                // ),
              ],
            ),
          )
      ),
    );
  }
}
