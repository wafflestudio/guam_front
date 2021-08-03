import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'custom_app_bar.dart';
import 'image_expanded.dart';
import '../models/thumbnail.dart';

class ImagesCarouselPage extends StatefulWidget {
  /*
  * images: for uploaded native image files via ImagePicker, etc.,
  * thumbnails: for network image paths (S3)
  * IMPORTANT: only 1 of above should be passed to parameter
  * */
  final List<Image> images;
  final List<Thumbnail> thumbnails;
  final int initialPage;
  final bool showImageActions;

  ImagesCarouselPage({this.images, this.thumbnails, this.initialPage, this.showImageActions});

  @override
  State<StatefulWidget> createState() => ImagesCarouselPageState();
}

class ImagesCarouselPageState extends State<ImagesCarouselPage> {
  List<Image> imagesState;
  List<Thumbnail> thumbnailsState;
  int currPage;

  @override
  void initState() {
    super.initState();
    imagesState = widget.images;
    thumbnailsState = widget.thumbnails;
    currPage = widget.initialPage ?? 0;
  }

  void switchPage(int idx) => setState(() {currPage = idx;});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.grey,
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailing: widget.showImageActions ? IconButton(
          icon: Icon(Icons.more_vert),
          color: Colors.grey,
          onPressed: () {},
        ) : null,
        backgroundColor: Colors.black,
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          initialPage: currPage,
          onPageChanged: (idx, _) => switchPage(idx)
        ),
        items: thumbnailsState != null
            ? thumbnailsState.map((e) => ImageExpanded(imagePath: e.path)).toList()
            : imagesState.map((e) => ImageExpanded(image: e)).toList()
      ),
    );
  }
}
