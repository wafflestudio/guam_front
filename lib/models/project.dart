import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../models/profile.dart';
import '../models/boards/thread.dart';
import '../models/boards/user_task.dart';
import '../models/stack.dart' as StackModel;
import '../models/thumbnail.dart';

class Project extends ChangeNotifier {
  final int id;
  final bool isRecruiting;

  /* parameters needed for projects tab */
  final String title;
  final String description;
  final String due;
  final Thumbnail thumbnail;
  final int backHeadCount;
  final int backLeftCount;
  final int designHeadCount;
  final int designLeftCount;
  final int frontHeadCount;
  final int frontLeftCount;
  final Profile leader;
  final List<StackModel.Stack> techStacks;

  /* parameters needed for boards tab */
  Thread notice;
  List<UserTask> tasks;
  List<Thread> threads;
  final Map<int, String> userStates; // { LEADER, MEMBER, GUEST, DECLINED, QUIT }

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
    this.userStates,
  });

  set _tasks(List<UserTask> _tasks) => tasks = _tasks;
  set _threads(List<Thread> _threads) => threads = _threads;

  factory Project.fromJson(Map<String, dynamic> json) {
    Thumbnail thumbnail;
    Thread notice;
    List<UserTask> tasks;
    List<StackModel.Stack> techStacks;
    Profile leader;
    Map<int, String> userStates = {};

    if (json['thumbnail'] != null) thumbnail = Thumbnail.fromJson(json['thumbnail']);

    if (json['noticeThread'] != null) {
      notice = Thread.fromJson(json['noticeThread']);
    }

    if (json['tasks'] != null) {
      tasks = [...json['tasks'].map((e) => UserTask.fromJson(e))];
      tasks.forEach((task) => userStates[task.user.id] = task.state);
      tasks = [...tasks.where((task) => ["LEADER", "MEMBER"].contains(task.state))];
    }

    if (json['techStacks'] != null) {
      techStacks = [...json['techStacks'].map((e) => StackModel.Stack.fromJson(e))];
    }

    if (json['leaderProfile'] != null) {
      leader = Profile.fromJson(json['leaderProfile']);
    }

    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: thumbnail,
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
      tasks: tasks,
      notice: notice,
      userStates: userStates,
    );
  }

  bool hasBoardData() {
    return title != null || tasks != null || threads != null;
  }
}
