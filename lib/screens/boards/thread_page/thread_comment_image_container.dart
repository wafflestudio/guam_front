import 'package:flutter/material.dart';
import 'package:guam_front/models/thumbnail.dart';
import '../../../models/thumbnail.dart';
import '../../../commons/image_thumbnail.dart';

class ThreadCommentImageContainer extends StatelessWidget {
  final Thumbnail img;
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
          child: IgnorePointer( // ignore image thumbnail's on tap
            ignoring: true,
            child: ImageThumbnail(imagePath: img.path),
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
