import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';
import 'thread_comment_image.dart';

class Comment extends ChangeNotifier {
  final int id;
  final int threadId;
  final Profile creator;
  final String content;
  final List<ThreadCommentImage> commentImages;
  final DateTime createdAt;
  final DateTime modifiedAt;

  Comment({
    this.id,
    this.threadId,
    this.creator,
    this.content,
    this.commentImages,
    this.createdAt,
    this.modifiedAt
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json["id"],
      threadId: json["threadId"],
      creator: Profile.fromJson({
        "id": json["creatorId"],
        "nickname": json["creatorNickname"],
        "imageUrl": json["creatorImageUrl"],
      }),
      content: json["content"],
      commentImages: [...json["commentImages"].map((e) => ThreadCommentImage.fromJson(e))],
      createdAt: DateTime.parse(json["createdAt"]),
      modifiedAt: DateTime.parse(json["modifiedAt"])
    );
  }
}
