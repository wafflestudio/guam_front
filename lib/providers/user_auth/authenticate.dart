import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helpers/http_request.dart';
import '../../models/profile.dart';
import '../../helpers/decode_ko.dart';

class Authenticate with ChangeNotifier {
  final _kakaoClientId = "367d8cf339e2ba59376ba647c7135dd2";
  final _kakaoJavascriptClientId = "2edf60d1ebf23061d200cfe4a68a235a";

  FirebaseAuth auth = FirebaseAuth.instance;
  Profile me;
  bool loading = false;

  get kakaoClientId => _kakaoClientId;
  get kakaoJavascriptClientId => _kakaoJavascriptClientId;

  Authenticate() {
    getMyProfile();
  }

  bool userSignedIn() => auth.currentUser != null; // 로그인 된 유저 존재 여부
  bool profileExists() => me != null && me.isProfileSet; // 프로필까지 만든 정상 유저인지 여부

  Future kakaoSignIn(String kakaoAccessToken) async {
    try {
      toggleLoading();
      await HttpRequest().get(
        path: "/kakao",
        queryParams: { "token": kakaoAccessToken },
      ).then((response) async {
        final customToken = jsonDecode(response.body)["customToken"];
        await auth.signInWithCustomToken(customToken);
        await getMyProfile();
      });
      notifyListeners();
    } catch (e) {
      print(e);
    } finally {
      toggleLoading();
    }
  }

  Future<String> getFirebaseIdToken() async {
    final idToken = await auth.currentUser.getIdToken();

    return idToken;
  }

  Future getMyProfile() async {
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest().get(
            path: "/user",
            authToken: authToken
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            me = Profile.fromJson(json.decode(jsonUtf8));
          }
          if (response.statusCode == 400) {
            print("Error loading user profile");
          }
        });
      }
    } catch (e) {
      print("Failed fetching my profile: $e");
    } finally {
      toggleLoading();
    }
  }

  Future setProfile(dynamic params) async {
    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();
      print(authToken);
      if (authToken.isNotEmpty) {
        await HttpRequest().post(
          path: "/user",
          body: params,
          authToken: authToken
        ).then((response) {
            if (response.statusCode == 200) {
              getMyProfile();
            }
        }).then((response) {
          print("Successfully updated profile.");
        });
      }
    } catch (e) {
      print(e);
    } finally {
      toggleLoading();
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
    notifyListeners();
  }

  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }
}
