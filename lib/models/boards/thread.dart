import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';
import '../thumbnail.dart';

class Thread extends ChangeNotifier {
  /*
  Below are fields initialized by boardsProvider.fetchThreads().
  Comments, Images are required only in ThreadPage,
  so it is requested by different method boardsProvider.fetchFullThread(),
  and thus is not preserved after widget disposed.
   */
  final int id;
  final Profile creator;
  final String content;
  final List<Thumbnail> threadImages;
  final int commentSize;
  final DateTime createdAt;
  final DateTime modifiedAt;

  Thread({
    this.id,
    this.creator,
    this.content,
    this.threadImages,
    this.commentSize,
    this.createdAt,
    this.modifiedAt
  });

  factory Thread.fromJson(Map<String, dynamic> json) {
    return Thread(
      id: json["id"],
      creator: Profile.fromJson({
        "id": json["creatorId"],
        "nickname": json["creatorNickname"],
        "imageUrl": json["creatorImageUrl"],
      }),
      content: json["content"],
      threadImages: [...json["threadImages"].map((e) => Thumbnail.fromJson(e))],
      commentSize: json["commentSize"],
      createdAt: DateTime.parse(json["createdAt"]).toLocal(),
      modifiedAt: DateTime.parse(json["modifiedAt"]).toLocal()
    );
  }
}
