import 'package:flutter/material.dart';
import 'package:guam_front/commons/closable_image_expanded.dart';
import 'package:guam_front/models/profile.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../helpers/http_request.dart';
import '../../../commons/closable_image_expanded.dart';

class MyProfileTop extends StatelessWidget {
  final Profile me;

  MyProfileTop(this.me);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: ClipOval(
                child: me.imageUrl != null
                  ? InkWell(
                    child: FadeInImage(
                      placeholder: MemoryImage(kTransparentImage),
                      image: NetworkImage(HttpRequest().s3BaseAuthority + me.imageUrl),
                      fit: BoxFit.cover
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => ClosableImageExpanded(imagePath: me.imageUrl))
                      );
                    }
                  ) : Icon(Icons.person, color: Colors.white, size: 90)
              ),
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
      ),
    );
  }
}
