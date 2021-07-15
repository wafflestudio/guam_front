import 'package:flutter/material.dart';
import 'package:guam_front/screens/my_page/my_profile/my_profile_top.dart';
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
                      child: Container(
                        padding: EdgeInsets.fromLTRB(15, 5, 0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _startBar("000000", 100, 5),
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text('🛠 기술 스택     ',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text("백엔드"),
                                ),
                                Expanded(
                                  child: _wrap(),
                                ),
                              ],
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  width: 100,
                                  padding: EdgeInsets.only(top: 15),
                                  child: Text("프론트엔드"),
                                ),
                                Expanded(
                                  child: _wrap(),
                                ),
                              ],
                            ),
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
                                SingleChildScrollView(
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(right: 5),
                                        child: SizedBox(
                                          width: 140,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 80),
                                              child: Text(
                                                "유튜브 제작하기",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(140, 140),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20), // <-- Radius
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SizedBox(
                                          width: 140,
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            child: Padding(
                                              padding: EdgeInsets.only(top: 80),
                                              child: Text(
                                                "딥러닝 스터디",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(140, 140),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        20), // <-- Radius
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  scrollDirection: Axis.horizontal,
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
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

  Widget _wrap() {
    return Wrap(
      spacing: 4,
      children: [
        _buildChip("asdf"),
        _buildChip("aㅁㄴㅇsdf"),
        _buildChip("asdf"),
        _buildChip("asㄹㅁㄴㅇdf"),
        _buildChip("asdf"),
        _buildChip("asㄹdf"),
        _buildChip("asdf"),
      ],
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

  Widget _buildChip(String label) {
    return Chip(
      backgroundColor: HexColor("#E9E9E9"),
      side: BorderSide(color: HexColor("#979797"), width: 0.5),
      labelPadding: EdgeInsets.symmetric(horizontal: 2),
      label: Text(
        label,
        style: TextStyle(
          fontSize: 12,
          color: Colors.black,
        ),
      ),
    );
  }
}
