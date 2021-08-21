import 'package:flutter/material.dart';
import '../../screens/projects/projects_app.dart';
import '../../screens/boards/boards_app.dart';
import '../../screens/my_page/my_page_app.dart';

class HomeProvider extends ChangeNotifier {
  int _idx = 0;

  final List<Widget> bodyItems = [
    ProjectsApp(),
    BoardsApp(),
    MyPage()
  ];

  final List<Map<String, dynamic>> bottomNavItems = [
    {
      'label': '프로젝트',
      'icon': Icons.home_filled,
    },
    {
      'label': '작업실',
      'icon': Icons.content_paste,
    },
    {
      'label': '프로필',
      'icon': Icons.account_circle,
    },
  ];

  get idx => _idx;

  set idx(val) {
    _idx = val;
    notifyListeners();
  }

  Widget get bodyItem => bodyItems[_idx];
  Map<String, dynamic> get bottomNavItem => bottomNavItems[_idx];
}
