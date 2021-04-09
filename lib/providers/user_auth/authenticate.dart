import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import '../../helpers/http_request.dart';

class Authenticate with ChangeNotifier {
  var _authToken;

  Authenticate() {
    initAuthToken();
  }

  get authToken => _authToken;
  set authToken(token) {
    _authToken = token;
    notifyListeners();
  }

  void initAuthToken() async {
    await FlutterSession()
        .get('authentication_token')
        .then((value) => this.authToken = value)
        .catchError((error) => print(error));
  }

  Future saveAuthToken(String authToken) async {
    this.authToken = authToken;
    await FlutterSession().set('authentication_token', authToken);
  }

  Future destroyAuthToken() async {
    this.authToken = null;
    await FlutterSession().set('authentication_token', '');
  }

  Future signIn({Map<String, dynamic> params}) async {
    await HttpRequest()
        .post(partialUrl: "sign_in", body: params)
        .then((response) => saveAuthToken(json.decode(response.body)['authentication_token']));
  }

  Future signUp({Map<String, dynamic> params}) async {
    await HttpRequest()
        .post(partialUrl: "sign_up", body: params)
        .then((response) => saveAuthToken(json.decode(response.body)['authentication_token']));
  }

  Future signOut({String authToken}) async {
    await HttpRequest()
        .delete(partialUrl: "sign_out", authToken: authToken)
        .then((response) => response);
  }
}
