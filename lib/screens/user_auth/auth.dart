import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import 'kakao_login.dart';

class Auth extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SvgPicture.asset('assets/logos/guam_logo.svg', color: HexColor('#6200EE')),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      child: Text('회원가입'),
                      onPressed: () => Navigator.pushNamed(context, '/sign_up'),
                    ),
                    RaisedButton(
                      child: Text('로그인'),
                      onPressed: () => Navigator.pushNamed(context, '/sign_in'),
                    ),
                  ]
                ),
                KakaoLogin(),
              ],
            )
          ],
        )
    );
  }
}
