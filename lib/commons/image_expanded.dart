import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';
import '../helpers/http_request.dart';
import 'custom_app_bar.dart';

class ImageExpanded extends StatelessWidget{
  final Widget image;
  final String imagePath;

  ImageExpanded({this.image, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        trailing: IconButton(
          icon: Icon(Icons.close),
          color: Colors.grey,
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        width: double.infinity,
        height: double.infinity,
        child: InteractiveViewer(
          child: image ?? FadeInImage(
            placeholder: MemoryImage(kTransparentImage),
            image: NetworkImage(HttpRequest().s3BaseAuthority + imagePath),
            fit: BoxFit.fitWidth,
          )
        ),
      ),
    );
  }
}
