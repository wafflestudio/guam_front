import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

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
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
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
    );
  }
}
