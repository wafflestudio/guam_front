import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:guam_front/models/profile.dart';

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
  final int backLeftCount;
  final int designHeadCount;
  final int designLeftCount;
  final int frontHeadCount;
  final int frontLeftCount;
  final Profile leader;
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
    this.backLeftCount,
    this.designHeadCount,
    this.designLeftCount,
    this.frontHeadCount,
    this.frontLeftCount,
    this.leader,
    this.techStacks,
    this.notice,
    this.tasks,
    this.threads,
  });

  set(List<Thread> _threads) => threads = _threads;

  factory Project.fromJson(Map<String, dynamic> json) {
    List<UserTask> tasks;
    List<StackModel.Stack> techStacks;
    Profile leader;

    if (json['tasks'] != null) {
      tasks = [...json['tasks'].map((e) => UserTask.fromJson(e))];
    }

    techStacks = [
      ...json['techStacks'].map((e) => StackModel.Stack.fromJson(e))
    ];

    json['leaderProfile'] != null
        ? leader = Profile.fromJson(json['leaderProfile'])
        : leader = null;

    return Project(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        thumbnail: json['thumbnail'],
        isRecruiting: json['isRecruiting'],
        due: json['due'],
        backHeadCount: json['backHeadCnt'],
        backLeftCount: json['backLeftCnt'],
        designHeadCount: json['designHeadCnt'],
        designLeftCount: json['designLeftCnt'],
        frontHeadCount: json['frontHeadCnt'],
        frontLeftCount: json['frontLeftCnt'],
        leader: leader,
        techStacks: techStacks,
        tasks: tasks);
  }

  bool hasBoardData() {
    return title != null || tasks != null || threads != null;
  }
}
