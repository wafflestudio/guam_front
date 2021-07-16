import 'package:flutter/material.dart';
import '../../../helpers/http_request.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../models/boards/thread_comment_image.dart';

class ThreadCommentImageContainer extends StatelessWidget {
  final ThreadCommentImage img;

  ThreadCommentImageContainer({@required this.img});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: FadeInImage.memoryNetwork(
        placeholder: kTransparentImage,
        image: HttpRequest().s3BaseAuthority + img.path,
        fit: BoxFit.cover,
      ),
    );
  }
}
