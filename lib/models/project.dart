import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/boards/thread.dart';
import '../models/boards/user_progress.dart';
import '../helpers/http_request.dart';

class Project extends ChangeNotifier {
  final int id;
  final String title;
  final bool isRecruiting;
  /* parameters needed for projects tab */
  final String description;
  final int time;
  final int difficulty;
  final String thumbnail;
  final String devType;
  final String frontFramework;
  final int frontHeadCount;
  final String backFramework;
  final int backHeadCount;
  final int designHeadCount;

  /* parameters needed for boards tab */
  final Thread notice;
  final List<UserProgress> progresses;
  final List<Thread> threads;

  Project({
    @required this.id,
    this.title,
    this.isRecruiting, // isRecruiting ? appear on projects tab
    this.description,
    this.time,
    this.difficulty,
    this.thumbnail,
    this.devType,
    this.frontFramework,
    this.frontHeadCount,
    this.backFramework,
    this.backHeadCount,
    this.designHeadCount,
    this.notice,
    this.progresses,
    this.threads,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    List<UserProgress> progresses;

    if (json['tasks'] != null) {
      progresses = [...json['tasks'].map((e) => UserProgress.fromJson(e))];
    }

    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      isRecruiting: json['isRecruiting'],
      time: json['time'],
      difficulty: json['difficulty'],
      devType: json['devType'],
      frontFramework: json['frontFramework'],
      frontHeadCount: json['frontLeftCnt'],
      backFramework: json['backFramework'],
      backHeadCount: json['backLeftCnt'],
      designHeadCount: json['designLeftCnt'],
      // field for boards
      progresses: progresses
    );
  }

  bool hasBoardData() {
    return title != null || progresses != null || threads != null;
  }
}
