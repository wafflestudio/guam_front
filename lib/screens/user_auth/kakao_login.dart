import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk/all.dart';

class KakaoLogin extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    KakaoContext.clientId = "367d8cf339e2ba59376ba647c7135dd2";
    KakaoContext.javascriptClientId = "2edf60d1ebf23061d200cfe4a68a235a";

    return KakaoLoginState();
  }
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
    setState(() => _isKakaoTalkInstalled = installed);
  }

  _issueAccessToken(String authCode) async {
    try {
      final token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token); // Store access token in AccessTokenStore for future API requests.
      return token;
    } catch (e) {
      print(e.toString());
    }
  }

  /*
  * Kakao login via browser
  */
  _loginWithKakao() async {
    try {
      final authCode = await AuthCodeClient.instance.request();
      final token = await _issueAccessToken(authCode);
      print("Access Token: ${token.accessToken}");
    } on KakaoAuthException catch (e) {
      print("Kakao Auth Exception:\n$e");
    } on KakaoClientException catch (e) {
      print("Kakao Client Exception:\n$e");
    } catch (e) {
      print(e);
    }
  }

  /*
  * Kakao login via KakaoTalk
  */
  _loginWithTalk() async {
    try {
      final authCode = await AuthCodeClient.instance.requestWithTalk();
      final token = await _issueAccessToken(authCode);
      print("Access Token: ${jsonDecode(token.accessToken)}");
    } on KakaoAuthException catch (e) {
      print("Kakao Auth Exception:\n$e");
    } on KakaoClientException catch (e) {
      print("Kakao Client Exception:\n$e");
    } catch (e) {
      print(e);
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
