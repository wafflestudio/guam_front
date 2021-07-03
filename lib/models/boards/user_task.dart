import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';

class UserTask extends ChangeNotifier {
  final int id;
  final Profile user;
  final String task;

  UserTask({
    this.id,
    this.user,
    this.task
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
      id: json["id"],
      user: Profile.fromJson(json["user"]),
      task: json["task"]
    );
  }
}
