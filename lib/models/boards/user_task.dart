import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';

class UserTask extends ChangeNotifier {
  final int id;
  final int projectId;
  final Profile user;
  final String task;
  final String state;

  UserTask({
    this.id,
    this.projectId,
    this.user,
    this.task,
    this.state,
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
      id: json["id"],
      projectId: json["projectId"],
      user: Profile.fromJson(json["user"]),
      task: json["taskMsg"],
      state: json["userState"],
    );
  }
}
