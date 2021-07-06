import 'package:flutter/material.dart';

class Stack extends ChangeNotifier {
  final int id;
  final String name;
  final List<String> aliases;
  final String thumbnail;
  final String position;

  Stack({
    this.id,
    this.name,
    this.aliases,
    this.thumbnail,
    this.position,
  });

  factory Stack.fromJson(Map<String, dynamic> json) {
    return Stack(
      id: json['id'],
      name: json['name'],
      aliases: json['aliases'].split(", "),
      thumbnail: json['thumbnail'],
      position: json['position'],
    );
  }


}
