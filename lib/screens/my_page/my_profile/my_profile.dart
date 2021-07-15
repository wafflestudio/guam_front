import 'package:flutter/material.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_image.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_link.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

import '../../../providers/user_auth/authenticate.dart';
import '../../user_auth/sign_out.dart';

class MyProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authProvider = context.watch<Authenticate>();
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(
        children: [
          DecoratedBox(
            decoration: BoxDecoration(
                image: DecorationImage(
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.7), BlendMode.dstATop),
              image: AssetImage("assets/backgrounds/profile-bg-1.png"),
              fit: BoxFit.cover,
            )),
            child: Column(
              children: [
                Stack(children: [
                  MyProfileLink(authProvider.me),
                  MyProfileTop(authProvider.me),
                ]),
                Container(
                  // height: size.height,
                  width: double.maxFinite,
                  child: Column(children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30),
                          topLeft: Radius.circular(30),
                        ),
                      ),
                      child: Column(children: <Widget>[
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _startBar("000000", 100, 5),
                              SizedBox(height: size.height * 0.015),
                              Text('🛠 기술 스택     ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                              Text(
                                'ㅁㄴㅇㄹㅁㄴㅇㄹ',
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text('✋ 자기 소개 ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Container(
                                      width: size.width,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 20, 10),
                                      color: HexColor("#FFEB94"),
                                      child: Text("ㅎㅇ"),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Text('📋 참여한 프로젝트 ',
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right: 20),
                                    child: Container(
                                      width: size.width,
                                      padding:
                                          EdgeInsets.fromLTRB(10, 10, 20, 10),
                                      color: HexColor("#FFEB94"),
                                      child: Text("ㅎㅇ"),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ]),
                    ),
                  ]),
                ),
              ],
            ),
          ),
          Center(
            child: SignOut(),
          )
        ],
      ),
    );
  }

  Widget _startBar(String color, double width, double height) {
    return Container(
      alignment: Alignment.center,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: HexColor(color),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  Widget _techStackChip(String techStack) {
    return ClipRect(
        child: CircleAvatar(
            child: Icon(Icons.person, color: Colors.white, size: 100)));
  }
}
