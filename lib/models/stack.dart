import 'package:flutter/material.dart';
import 'thumbnail.dart';

class Stack extends ChangeNotifier {
  final int id;
  final String name;
  final List<String> aliases;
  final Thumbnail thumbnail;
  final String position;

  Stack({
    this.id,
    this.name,
    this.aliases,
    this.thumbnail,
    this.position,
  });

  factory Stack.fromJson(Map<String, dynamic> json) {
    Thumbnail thumbnail;

    if (json['thumbnail'] != null) thumbnail = Thumbnail.fromJson(json['thumbnail']);

    return Stack(
      id: json['id'],
      name: json['name'],
      aliases: json['aliases'].split(", "),
      thumbnail: thumbnail,
      position: json['position'],
    );
  }
}
