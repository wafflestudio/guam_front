import 'package:flutter/material.dart';
import 'package:guam_front/models/stack.dart' as TechStack;
import 'package:transparent_image/transparent_image.dart';

import '../helpers/http_request.dart';

class TechStackThumbnail extends StatelessWidget {
  final TechStack.Stack techStack;
  final double radius;

  TechStackThumbnail({
    this.techStack,
    this.radius,
  });

  @override
  Widget build(BuildContext context) {
    if (techStack.thumbnail.path != null) {
      return Container(
        child: Container(
          height: 2 * radius,
          width: 2 * radius,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: ClipOval(
              child: FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(
                HttpRequest().s3BaseAuthority + techStack.thumbnail.path),
            fit: BoxFit.cover,
          )),
        ),
      );
    } else {
      return Container();
    }
  }
}
