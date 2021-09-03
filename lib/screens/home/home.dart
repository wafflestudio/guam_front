import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../providers/home/home_provider.dart';
import '../tutorial/tutorial_modal.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showTutorial();
    });
  }

  Future<void> showTutorial() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool seenTutorial = prefs.getBool("seenTutorial") ?? false;

    if (seenTutorial) return; // No need to show tutorial twice.

    Future<void> onExit() async {
      await prefs.setBool("seenTutorial", true);
      Navigator.of(context).pop();
    }
    showDialog(
      context: context,
      builder: (_) => TutorialModal(onExit: onExit)
    );
  }

  @override
  Widget build(BuildContext context) {
    final homeProvider = context.watch<HomeProvider>();

    return Scaffold(
      body: homeProvider.bodyItem,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (idx) => homeProvider.idx = idx,
        currentIndex: homeProvider.idx,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: homeProvider.bottomNavItems.map((e) =>
            BottomNavigationBarItem(
              label: e['label'],
              icon: Icon(e['icon']),
            )
        ).toList(),
      ),
    );
  }
}
