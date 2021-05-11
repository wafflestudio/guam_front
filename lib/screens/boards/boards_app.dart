import 'package:flutter/material.dart';
import '../../commons/app_bar.dart';

class BoardsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: '작업실',
        leading: IconButton(
          icon: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () {}
        ),
        trailing: IconButton(
            icon: Icon(
              Icons.notifications_none,
              color: Colors.white,
            ),
            onPressed: () {}
        ),
      ),
      // body: MyPageBody()
    );
  }
}


