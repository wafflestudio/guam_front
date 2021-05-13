import 'package:flutter/material.dart';
import '../../commons/app_bar.dart';
import 'my_page_body.dart';

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        title: "프로필",
        trailing: IconButton(
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
        ),
      ),
      body: MyPageBody(),
    );
  }
}
