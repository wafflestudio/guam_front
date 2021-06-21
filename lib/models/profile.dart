import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Profile extends ChangeNotifier {
  final int id;
  final String nickname;
  final String imageUrl;
  final String githubUrl;
  final String blogUrl;
  final List<dynamic> skills;
  final String introduction;
  final bool isProfileSet;

  Profile({
    this.id,
    this.nickname,
    this.imageUrl,
    this.githubUrl,
    this.blogUrl,
    this.skills,
    this.introduction,
    this.isProfileSet,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> data = json["data"];

    return Profile(
      id: data["id"],
      nickname: data["nickname"],
      imageUrl: data["imageUrl"],
      githubUrl: data["githubUrl"],
      blogUrl: data["blogUrl"],
      skills: data["skills"],
      introduction: data["introduction"],
      isProfileSet: data["isProfileSet"],
    );
  }
}
