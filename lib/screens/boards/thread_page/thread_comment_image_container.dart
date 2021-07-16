import 'package:flutter/material.dart';
import '../../../helpers/http_request.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../models/boards/thread_comment_image.dart';

class ThreadCommentImageContainer extends StatelessWidget {
  final ThreadCommentImage img;
  final bool blur;
  final int hiddenImgCnt;

  ThreadCommentImageContainer({@required this.img, this.blur, this.hiddenImgCnt});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: FadeInImage(
              placeholder: MemoryImage(kTransparentImage),
              image: NetworkImage(HttpRequest().s3BaseAuthority + img.path),
              fit: BoxFit.cover,
            ),
          ),
        ),
        if (blur) Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(120, 120, 120, 0.5),
            borderRadius: BorderRadius.circular(5)
          ),
        ),
        if (blur) Center(
          child: Text(
            "+$hiddenImgCnt",
            style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
                color: Colors.white
            ),
          ),
        )
      ],
    );
  }
}
