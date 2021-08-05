import 'package:flutter/material.dart';
import '../models/profile.dart';
import 'package:transparent_image/transparent_image.dart';
import '../helpers/http_request.dart';

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
          Container(
            height: 2 * radius,
            width: 2 * radius,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: profile.imageUrl != null ? Colors.transparent : Colors.grey,
            ),
            child: ClipOval(
                child: profile.imageUrl != null
                    ? FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(HttpRequest().s3BaseAuthority + profile.imageUrl),
                      fit: BoxFit.cover)
                    : Icon(Icons.person, color: Colors.white, size: 2 * radius)
            ),
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
