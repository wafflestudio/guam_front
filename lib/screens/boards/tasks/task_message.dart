import 'package:flutter/material.dart';
import '../../../models/boards/task_msg.dart';
import '../../../providers/boards/boards.dart';
import 'package:provider/provider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../../commons/bottom_modal/bottom_modal_content.dart';
import 'dart:io' show Platform;

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
    final boardsProvider = context.read<Boards>();
    final String taskMsgEllipsis = widget.taskMsg.msg.length > 15
        ? widget.taskMsg.msg.replaceRange(15, null, "...")
        : widget.taskMsg.msg;

    done = widget.taskMsg.status == "DONE";

    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: GestureDetector(
            onLongPress: () {
              if (widget.isMyTaskMsg) {
                if (Platform.isAndroid) {
                  showMaterialModalBottomSheet(
                      context: context,
                      builder: (_) => BottomModalContent(
                          deleteText: "'$taskMsgEllipsis' 삭제",
                          deleteDetailText: "해당 작업 현황을 정말 삭제하시겠습니까?",
                          deleteFunc: () async {
                            await boardsProvider.deleteTaskMsg(taskMsgId: widget.taskMsg.id)
                                .then((successful) {
                              if (successful) Navigator.of(context).pop();
                            });
                          }
                      )
                  );
                } else {
                  showCupertinoModalBottomSheet(
                      context: context,
                      builder: (_) => BottomModalContent(
                          deleteText: "'$taskMsgEllipsis' 삭제",
                          deleteDetailText: "해당 작업 현황을 정말 삭제하시겠습니까?",
                          deleteFunc: () async {
                            await boardsProvider.deleteTaskMsg(taskMsgId: widget.taskMsg.id)
                                .then((successful) {
                              if (successful) Navigator.of(context).pop();
                            });
                          }
                      )
                  );
                }
              }
            },
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
            ),
          )
      ),
    );
  }
}
