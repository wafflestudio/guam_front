import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import '../profile.dart';

class UserProgress extends ChangeNotifier {
  final Profile user;
  final String progress;

  UserProgress({
    this.user,
    this.progress
  });
}
