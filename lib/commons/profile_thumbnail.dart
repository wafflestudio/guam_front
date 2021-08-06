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

  Color randomColor() {
    final int randInt = profile.id % 5;
    Color res;

    switch(randInt) {
      case 0: res = Color.fromRGBO(255, 136, 155, 1); break;
      case 1: res =  Color.fromRGBO(0, 141, 232, 1); break;
      case 2: res = Color.fromRGBO(141, 64, 0, 1); break;
      case 3: res = Color.fromRGBO(255, 223, 82, 1); break;
      case 4: res = Color.fromRGBO(8, 149, 28, 1); break;
    }

    return res;
  }

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
                    : Icon(Icons.person, color: randomColor(), size: 2 * radius)
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
