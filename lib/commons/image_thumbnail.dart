import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../helpers/http_request.dart';
import 'closable_image_expanded.dart';

class ImageThumbnail extends StatelessWidget {
  /*
  * image: for uploaded image file via ImagePicker, etc.,
  * imagePath: for network image path (S3)
  * IMPORTANT: only 1 of above should be passed to parameter
  * */
  final Widget image;
  final String imagePath;
  final double height;
  final double width;
  final bool activateOnTap; // false in case of carousel usage of image list

  ImageThumbnail({this.image, this.imagePath, this.height, this.width, this.activateOnTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: height,
        width: width,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: image ?? FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(HttpRequest().s3BaseAuthority + imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
      onTap: () {
        if (activateOnTap) Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ClosableImageExpanded(
              image: image ?? null,
              imagePath: imagePath ?? null
            )
          )
        );
      }
    );
  }
}
