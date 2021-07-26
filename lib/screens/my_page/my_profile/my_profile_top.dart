import 'package:flutter/material.dart';
import 'package:guam_front/helpers/http_request.dart';
import 'package:guam_front/models/profile.dart';
import 'package:transparent_image/transparent_image.dart';

class MyProfileTop extends StatelessWidget {
  final Profile me;

  MyProfileTop(this.me);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
          child: Container(
            padding: EdgeInsets.only(top: 20),
            child: ClipRRect(
                child: CircleAvatar(
                    backgroundColor: Colors.black38,
                    radius: 50,
                    child: (me.imageUrl == null)
                        ? Icon(Icons.person, color: Colors.white, size: 90)
                        : ClipOval(
                            child: FadeInImage(
                                placeholder: MemoryImage(kTransparentImage),
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    HttpRequest().s3BaseAuthority +
                                        me.imageUrl)),
                          ))),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(20),
          child: Text(
            me.nickname ?? "",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
