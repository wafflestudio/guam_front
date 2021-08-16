import 'package:flutter/material.dart';
import 'package:guam_front/models/profile.dart';
import 'package:url_launcher/url_launcher.dart';

class ProfileLink extends StatelessWidget {
  final Profile me;

  ProfileLink(this.me);

  _launchURL(String url) async =>
      await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6, right: 8),
      child: Row(
        children: [
          Expanded(child: Container()),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: IconButton(
                          onPressed: () => _launchURL(me.blogUrl),
                          padding: EdgeInsets.all(2),
                          icon: Image.asset('assets/images/browser-icon.png')),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: IconButton(
                            onPressed: () => _launchURL(
                                "https://github.com/" + me.githubUrl),
                            padding: EdgeInsets.all(2),
                            icon:
                                Image.asset('assets/images/github-icon.png'))),
                  ),
                  // Padding(
                  //   padding: EdgeInsets.symmetric(horizontal: 3),
                  //   child: SizedBox(
                  //     height: 24,
                  //     width: 24,
                  //     child: IconButton(
                  //         onPressed: () {},
                  //         // flutter 공식 plugin에서 지원하는 share 라이브러리가 있긴 한데, deprecated군요...
                  //         padding: EdgeInsets.only(bottom: 2),
                  //         iconSize: 20,
                  //         icon: Icon(Icons.ios_share)),
                  //   ),
                  // )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
