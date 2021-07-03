import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';
import 'comment.dart';

class Thread extends ChangeNotifier {
  final int id;
  final Profile creator;
  final String content;
  final List<Comment> comments;
  final int commentSize;
  final DateTime createdAt;
  final DateTime modifiedAt;

  Thread({
    this.id,
    this.creator,
    this.content,
    this.comments,
    this.commentSize,
    this.createdAt,
    this.modifiedAt
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json["id"],
      creator: Profile.fromJson(json["creator"]),
      content: json["content"],
      //comments:
      commentSize: json["commentSize"],
      createdAt: DateTime.parse(json["createdAt"]),
      modifiedAt: DateTime.parse(json["modifiedAt"])
    );
  }
}
