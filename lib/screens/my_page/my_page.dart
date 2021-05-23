import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../user_auth/kakao_login.dart';
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
      /*
      * If User instance not exists.. show Kakao login
      */
      body: Container(
        child: Center(
          child: Column(
            children: [
              KakaoLogin(),
            ],
          )
        ),
      ),
      /*
      * If User instance exists.. show MyPageBody
      */
      // body: MyPageBody(),
    );
  }
}
