import 'package:flutter/material.dart';
import '../models/profile.dart';

class ProfileThumbnail extends StatelessWidget {
  final Profile profile;
  final double size;
  final bool showNickname;

  ProfileThumbnail({
    this.profile,
    this.size,
    this.showNickname,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(profile.profileImage),
            backgroundColor: Colors.transparent,
            radius: size,
          ),
          if (showNickname) Text(profile.nickname),
        ],
      ),
    );
  }
}
