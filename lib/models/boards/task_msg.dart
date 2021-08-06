import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TaskMsg extends ChangeNotifier {
  final int id;
  final String msg;
  final String status; // { ONGOING, DONE }
  final int taskId;

  TaskMsg({this.id, this.msg, this.status, this.taskId});

  factory TaskMsg.fromJson(Map<String, dynamic> json) {
    return TaskMsg(
      id: json["id"],
      msg: json["msg"],
      status: json["status"],
      taskId: json["taskId"],
    );
  }
}
