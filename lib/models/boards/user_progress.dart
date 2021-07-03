import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';

class UserProgress extends ChangeNotifier {
  final int id;
  final Profile user;
  final String progress;

  UserProgress({
    this.id,
    this.user,
    this.progress
  });

  factory UserProgress.fromJson(Map<String, dynamic> task) {
    print(task['id']);
    print(task['user']);
    print(task['task']);

    return UserProgress(
      id: task["id"],
      user: Profile.fromJson(task["user"]),
      progress: task["task"]
    );
  }
}
