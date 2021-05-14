import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

class KakaoLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => KakaoLoginState();
}

class KakaoLoginState extends State<KakaoLogin> {
  bool _isKakaoTalkInstalled;

  @override
  void initState() {
    _initKakaoTalkInstalled();
    super.initState();
  }

  void _initKakaoTalkInstalled() async {
    final installed = await isKakaoTalkInstalled();
    print("is kakao installed: $installed");
    setState(() {
      _isKakaoTalkInstalled = installed;
    });
  }

  Future<AccessTokenResponse> _issueAccessToken(String authCode) async {
    try {
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      return token;
    } catch (e) {
      print(e.toString());
    }
  }

  _loginWithKakao() async {
    try {
      var code = await AuthCodeClient.instance.request();
      var token = await _issueAccessToken(code);
      print(token.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  _loginWithTalk() async {
    try {
      var code = await AuthCodeClient.instance.requestWithTalk();
      var token = await _issueAccessToken(code);
      print(token.toString());
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
  return InkWell(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Image(
          image: AssetImage("assets/buttons/kakao_login_medium_narrow.png"),
        ),
      ),
      onTap: () => _isKakaoTalkInstalled ? _loginWithTalk() : _loginWithKakao(),
    );
  }
}
