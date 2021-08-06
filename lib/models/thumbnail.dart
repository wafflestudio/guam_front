import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class Thumbnail {
  final int id;
  final String path;

  Thumbnail({this.id, @required this.path});

  factory Thumbnail.fromJson(dynamic json) {
    return Thumbnail(
      id: json["id"],
      path: json["path"],
    );
  }
}
