import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../models/boards/thread.dart';
import '../models/boards/user_progress.dart';

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

  /* parameters needed for boards tab */
  final Thread notice;
  final List<UserProgress> progresses;
  final List<Thread> threads;

  Project({
    @required this.id,
    @required this.title,
    @required this.isRecruiting, // isRecruiting ? appear on projects tab
    this.description,
    this.time,
    this.difficulty,
    this.thumbnail,
    this.devType,
    this.frontFramework,
    this.frontHeadCount,
    this.backFramework,
    this.backHeadCount,
    this.notice,
    this.progresses,
    this.threads,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      isRecruiting: json['isRecruiting'],
      description: json['description'],
      time: json['time'],
      difficulty: json['difficulty'],
      thumbnail: json['thumbnail'],
      devType: json['devType'],
      frontFramework: json['frontFramework'],
      frontHeadCount: json['frontHeadCount'],
      backFramework: json['backFramework'],
      backHeadCount: json['backHeadCount'],
    );
  }
}
