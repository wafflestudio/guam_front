import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';

class UserTask extends ChangeNotifier {
  final int id;
  final Profile user;
  final String task;
  final String position;

  UserTask({
    this.id,
    this.user,
    this.task,
    this.position,
  });

  factory UserTask.fromJson(Map<String, dynamic> json) {
    return UserTask(
      id: json["id"],
      user: Profile.fromJson(json["user"]),
      task: json["task"],
      position: json["position"],
    );
  }
}
