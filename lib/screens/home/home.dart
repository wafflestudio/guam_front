import 'package:flutter/material.dart';
import 'package:guam_front/main.dart';
import 'package:provider/provider.dart';
import '../../providers/home/home_provider.dart';

class Home extends StatelessWidget {
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: MyApp.themeColor,
      ),
    );
  }
}
