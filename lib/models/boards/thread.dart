import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';
import 'comment.dart';

class Thread extends ChangeNotifier {
  final int id;
  final Profile creator;
  final String content;
  final List<Comment> comments;
  final bool isEdited;
  final DateTime createdAt;
  final bool isNotice;

  Thread({
    this.id,
    this.creator,
    this.content,
    this.comments,
    this.isEdited,
    this.createdAt,
    this.isNotice, // 공지인 thread: server side에서 boards 내려줄 때 field로 받기
  });
}
