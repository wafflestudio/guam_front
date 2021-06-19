import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileThumbnail extends StatelessWidget {
  final Profile profile;
  final double radius; // 반지름
  final bool showNickname;
  final Color textColor;

  ProfileThumbnail({
    this.profile,
    this.radius,
    this.showNickname,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profile.imageUrl),
            backgroundColor: Colors.transparent,
            radius: radius,
          ),
          if (showNickname) Padding(
            padding: EdgeInsets.only(left: 10),
            child: Text(
              profile.nickname,
              style: TextStyle(color: textColor),
            ),
          )
        ],
      ),
    );
  }
}
