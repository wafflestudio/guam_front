import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';
import 'task_msg.dart';

class UserTask extends ChangeNotifier {
  final int id;
  final int projectId;
  final Profile user;
  final List<TaskMsg> taskMessages;
  final String state;

  UserTask({
    this.id,
    this.projectId,
    this.user,
    this.taskMessages,
    this.state,
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    List<TaskMsg> taskMessages;

    if (json["taskMsg"] != null) taskMessages = [...json["taskMsg"].map((msg) => TaskMsg.fromJson(msg))];

    return UserTask(
      id: json["id"],
      projectId: json["projectId"],
      user: Profile.fromJson(json["user"]),
      taskMessages: taskMessages,
      state: json["userState"],
    );
  }
}
