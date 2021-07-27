import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class ThreadCommentImage {
  final int id;
  final String path;

  ThreadCommentImage({@required this.id, @required this.path});

  factory ThreadCommentImage.fromJson(dynamic json) {
    return ThreadCommentImage(
      id: json["id"],
      path: json["path"],
    );
  }
}
