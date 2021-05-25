import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Profile extends ChangeNotifier {
  final int id;
  final String nickname; // 원식님이 name 으로 해놔서 바꿔달라고 요청한 상태.
  final String imageUrl;
  final String githubUrl;
  final String blogUrl;
  final String skills;
  final String introduction;

  Profile({
    this.id,
    this.nickname,
    this.imageUrl,
    this.githubUrl,
    this.blogUrl,
    this.skills,
    this.introduction,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"],
      nickname: json["nickname"],
      imageUrl: json["imageUrl"],
      githubUrl: json["githubUrl"],
      blogUrl: json["blogUrl"],
      skills: json["skills"],
      introduction: json["introduction"],
    );
  }

}
