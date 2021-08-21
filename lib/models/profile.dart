import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'project.dart';

class Profile extends ChangeNotifier {
  final int id;
  final String status;
  final String nickname;
  final String imageUrl;
  final String githubUrl;
  final String blogUrl;
  final List<dynamic> skills;
  final String introduction;
  final bool isProfileSet;
  final List<Project> projects;

  Profile({
    this.id,
    this.status,
    this.nickname,
    this.imageUrl,
    this.githubUrl,
    this.blogUrl,
    this.skills,
    this.introduction,
    this.isProfileSet,
    this.projects,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    List<Project> projects;

    if (json["projects"] != null) {
      projects = [...json["projects"].map((prj) => Project.fromJson({
        "id": prj["projectId"],
        "title": prj["projectTitle"],
        "thumbnail": {
          "path": prj["projectThumbnail"]
        },
      }))];
    }

    return Profile(
      id: json["id"],
      status: json["status"],
      nickname: json["nickname"],
      imageUrl: json["imageUrl"],
      githubUrl: json["githubUrl"],
      blogUrl: json["blogUrl"],
      skills: json["skills"],
      introduction: json["introduction"],
      isProfileSet: json["isProfileSet"],
      projects: projects
    );
  }
}
