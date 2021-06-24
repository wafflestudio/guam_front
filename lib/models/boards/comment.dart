import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';

class Comment extends ChangeNotifier {
  final int id;
  final Profile creator;
  final String content;
  final bool isEdited;
  final DateTime createdAt;

  Comment({
    this.id,
    this.creator,
    this.content,
    this.isEdited,
    this.createdAt,
  });
}
