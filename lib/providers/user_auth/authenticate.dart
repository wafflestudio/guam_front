import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../helpers/http_request.dart';
import '../../models/profile.dart';

class Authenticate with ChangeNotifier {
  final _kakaoClientId = "367d8cf339e2ba59376ba647c7135dd2";
  final _kakaoJavascriptClientId = "2edf60d1ebf23061d200cfe4a68a235a";

  FirebaseAuth auth = FirebaseAuth.instance;
  Profile me;
  bool loading = false;

  get kakaoClientId => _kakaoClientId;
  get kakaoJavascriptClientId => _kakaoJavascriptClientId;

  bool userSignedIn() => auth.currentUser != null;

  Future kakaoSignIn(String kakaoAccessToken) async {
    try {
      toggleLoading();
      await HttpRequest().get(
        authority: HttpRequest().kakaoAuthority,
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
      String authToken = await getFirebaseIdToken();
      if (authToken.isNotEmpty) {
        await HttpRequest().get(
            path: "/user",
            authToken: authToken
        ).then((response) {
          if (response.statusCode == 400) {
            // User has no profile
            print("Set user profile");
          } else {
            // Initialize user

          }
        });
      }
    } catch (e) {
      print("Failed fetching my profile: $e");
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

  bool meExists() => me != null;
}
