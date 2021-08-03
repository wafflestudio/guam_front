import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'custom_app_bar.dart';
import 'image_expanded.dart';
import '../models/thumbnail.dart';

class ImagesCarouselPage extends StatelessWidget {
  /*
  * images: for uploaded native image files via ImagePicker, etc.,
  * thumbnails: for network image paths (S3)
  * IMPORTANT: only 1 of above should be passed to parameter
  * */
  final List<Image> images;
  final List<Thumbnail> thumbnails;
  final int initialPage;

  ImagesCarouselPage({this.images, this.thumbnails, this.initialPage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.grey,
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailing: IconButton(
          icon: Icon(Icons.more_vert),
          color: Colors.grey,
          onPressed: () {},
        ),
        backgroundColor: Colors.black,
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          initialPage: initialPage ?? 0
        ),
        items: thumbnails != null
          ? thumbnails.map((e) => ImageExpanded(imagePath: e.path)).toList()
          : images.map((e) => ImageExpanded(image: e)).toList()
      ),
    );
  }
}
