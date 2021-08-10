import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helpers/decode_ko.dart';
import '../../helpers/http_request.dart';
import '../../models/profile.dart';

class Authenticate with ChangeNotifier {
  final _kakaoClientId = "367d8cf339e2ba59376ba647c7135dd2";
  final _kakaoJavascriptClientId = "2edf60d1ebf23061d200cfe4a68a235a";

  FirebaseAuth auth = FirebaseAuth.instance;
  Profile me;
  Profile user; //user 없애기
  bool loading = false;

  get kakaoClientId => _kakaoClientId;

  get kakaoJavascriptClientId => _kakaoJavascriptClientId;

  Authenticate() {
    getMyProfile();
  }

  bool userSignedIn() => auth.currentUser != null && me != null; // 로그인 된 유저 존재 여부
  bool profileExists() => me != null && me.isProfileSet; // 프로필까지 만든 정상 유저인지 여부

  Future kakaoSignIn(String kakaoAccessToken) async {
    try {
      toggleLoading();
      await HttpRequest().get(
        path: "/kakao",
        queryParams: {"token": kakaoAccessToken},
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
        await HttpRequest()
          .get(
            path: "/user/me",
            authToken: authToken,
        ).then((response) {
          if (response.statusCode == 200) {
            final jsonUtf8 = decodeKo(response);
            final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
            me = Profile.fromJson(jsonData);
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

  Future setProfile({Map<String, dynamic> fields, dynamic files}) async {
    bool res = false;

    try {
      toggleLoading();
      String authToken = await getFirebaseIdToken();
      print(authToken);

      if (authToken.isNotEmpty) {
        await HttpRequest()
          .postMultipart(
            path: "/user",
            fields: { "command" : "${json.encode(fields)}" },
            files: files,
            authToken: authToken)
          .then((response) async {
            if (response.statusCode == 200) {
              getMyProfile();
              print("Successfully updated profile.");
              res = true;
            } else {
              String err;

              switch (response.statusCode) {
                case 201: err = "Successfully created profile."; break;
                case 401: err = "Unauthorized."; break;
                case 403: err = "Forbidden to set a profile."; break;
                case 404: err = "Not Found"; break;
                case 500: err = "Internal Server Error"; break;
              }

              throw new Exception(err);
            }
          });

        return res;
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

  Future getUserProfile(int userId) async {
    try {
      toggleLoading();
      await HttpRequest()
          .get(
        path: "/user/$userId",
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final Map<String, dynamic> jsonData = json.decode(jsonUtf8)["data"];
          user = Profile.fromJson(jsonData);
        } else{
          String err;

          switch(response.statusCode) {
            case 401: err = "Unauthorized"; break;
            case 403: err = "Forbidden"; break;
            case 404: err = "Not Found"; break;
            case 500: err = "Internal server error"; break;
          }

          throw new Exception(err);
        }
      });
    } catch (e) {
      print("Failed fetching the user profile: $e");
    } finally {
      toggleLoading();
    }
  }


  void toggleLoading() {
    loading = !loading;
    notifyListeners();
  }
}
