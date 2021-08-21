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
    Profile user;

    if (json["user"] != null) user = Profile.fromJson(json["user"]);
    if (json["taskMessages"] != null) taskMessages = [...json["taskMessages"].map((msg) => TaskMsg.fromJson(msg))];

    return UserTask(
      id: json["id"],
      projectId: json["projectId"],
      user: user,
      taskMessages: taskMessages,
      state: json["userState"],
    );
  }
}
