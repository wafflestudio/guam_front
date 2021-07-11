import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../models/boards/thread.dart';
import '../models/boards/user_task.dart';
import '../models/stack.dart' as StackModel;

class Project extends ChangeNotifier {
  final int id;
  final bool isRecruiting;

  /* parameters needed for projects tab */
  final String title;
  final String description;
  final String due;
  final String thumbnail;
  final int backHeadCount;
  final int designHeadCount;
  final int frontHeadCount;
  final List<StackModel.Stack> techStacks;

  /* parameters needed for boards tab */
  final Thread notice;
  final List<UserTask> tasks;
  List<Thread> threads;

  Project({
    @required this.id,
    this.title,
    this.isRecruiting, // isRecruiting ? appear on projects tab
    this.description,
    this.due,
    this.thumbnail,
    this.backHeadCount,
    this.designHeadCount,
    this.frontHeadCount,
    this.techStacks,
    this.notice,
    this.tasks,
    this.threads,
  });

  set(List<Thread> _threads) => threads = _threads;

  factory Project.fromJson(Map<String, dynamic> json) {
    List<UserTask> tasks;
    List<StackModel.Stack> techStacks;

    if (json['tasks'] != null) {
      tasks = [...json['tasks'].map((e) => UserTask.fromJson(e))];
    }

    techStacks = [
      ...json['techStacks'].map((e) => StackModel.Stack.fromJson(e))
    ];

    return Project(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        thumbnail: json['thumbnail'],
        isRecruiting: json['isRecruiting'],
        due: json['due'],
        backHeadCount: json['backLeftCnt'],
        designHeadCount: json['designLeftCnt'],
        frontHeadCount: json['frontLeftCnt'],
        techStacks: techStacks,
        // field for boards
        tasks: tasks);
  }

  bool hasBoardData() {
    return title != null || tasks != null || threads != null;
  }
}
