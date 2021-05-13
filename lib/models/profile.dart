import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Profile extends ChangeNotifier {
  final int id;
  final String nickname;
  final String profileImage;
  final String githubLink;
  final String websiteLink;
  final List<dynamic> skillSet;
  final String introduction;
  final DateTime createdAt;

  Profile({
    this.id,
    this.nickname,
    this.profileImage,
    this.githubLink,
    this.websiteLink,
    this.skillSet,
    this.introduction,
    this.createdAt
  });

}
