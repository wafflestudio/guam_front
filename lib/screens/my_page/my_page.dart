import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../user_auth/kakao_login.dart';
import '../../commons/app_bar.dart';
import 'my_page_body.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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
              IconButton(
                  onPressed: () async {
                    var auth = FirebaseAuth.instance;
                    var customToken = "eyJhbGciOiJSUzI1NiJ9.eyJhdWQiOiJodHRwczovL2lkZW50aXR5dG9vbGtpdC5nb29nbGVhcGlzLmNvbS9nb29nbGUuaWRlbnRpdHkuaWRlbnRpdHl0b29sa2l0LnYxLklkZW50aXR5VG9vbGtpdCIsImV4cCI6MTYyMTYxMTIxOSwiaWF0IjoxNjIxNjA3NjE5LCJpc3MiOiJmaXJlYmFzZS1hZG1pbnNkay0xbzFoZ0B3YWZmbGUtZ3VhbS5pYW0uZ3NlcnZpY2VhY2NvdW50LmNvbSIsInN1YiI6ImZpcmViYXNlLWFkbWluc2RrLTFvMWhnQHdhZmZsZS1ndWFtLmlhbS5nc2VydmljZWFjY291bnQuY29tIiwidWlkIjoiVkFnejRsd3BhcFBKREtocmg4SWtLcUp4NXFjMiJ9.axtmOG7b2KHsr1tFRc4JR7cOYrKd5JhqJvDz-_j5tk_nIGHPkEz4UDMCyJXKpnEWoeyihiGaGZUZVX2zNBytOmU_VSiuuSuV1DTKL108RzpQBG2NkGrwmnYPqQWILoRFaB197QRrwGN82hHF2nMm0T4WGNhqWH19jXPFH3yry-R2Psyqq3NmS4lI_A5NciCRGtzkAuOHX4_eXnAvGmtY8zOKoSTK7ec5P66ODw0k7pt1oqYei92t7rJ2E1o-g0cuZ-XCabdCT2uH8d9RnBy2y_CHck2eWkjhux-LKGZo2HJplEPe6gMBjEL_6uODSQhSRUPdWW9QmsxPa0iS_M8GNw";
                    UserCredential userCredential = await auth.signInWithCustomToken(customToken);
                    var firebaseToken = userCredential.user.getIdToken().then((value) => print(value)); // server gateway로 (user/me/) -> 200 user exists. 401 user exists but just made.

                  },
                  icon: Icon(Icons.settings))
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
