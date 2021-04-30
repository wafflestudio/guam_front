import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Project extends ChangeNotifier {
  final int id;
  final String title;
  final String description;
  final int difficulty;
  final String thumbnail;
  final String devType;
  final String frontFramework;
  final int frontHeadCount;
  final String backFramework;
  final int backHeadCount;
  final bool isRecruiting;

  Project({
    @required this.id,
    @required this.title,
    this.description,
    @required this.difficulty,
    this.thumbnail,
    @required this.devType,
    @required this.frontFramework,
    @required this.frontHeadCount,
    @required this.backFramework,
    @required this.backHeadCount,
    @required this.isRecruiting,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
        id: json['id'],
        title: json['title'],
        difficulty: json['difficulty'],
        devType: json['devType'],
        frontFramework: json['frontFramework'],
        frontHeadCount: json['frontHeadCount'],
        backFramework: json['backFramework'],
        backHeadCount: json['backHeadCount'],
        isRecruiting: json['isRecruiting'],
    );
  }
}
