import 'package:flutter/material.dart';
import '../../commons/app_bar.dart';
import 'my_page_body.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('프로필'),
        actions: [
          IconButton(icon: Icon(
            Icons.settings,
            color: Colors.white,
          ),
              onPressed: () {})
        ],
      ),
      body: MyPageBody(),
    );
  }
}
