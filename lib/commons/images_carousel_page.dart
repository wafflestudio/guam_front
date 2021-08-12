import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'custom_app_bar.dart';
import 'image_expanded.dart';
import '../models/thumbnail.dart';
import 'bottom_modal/bottom_modal_content.dart';
import 'dart:math';
import 'dart:io' show Platform;

class ImagesCarouselPage extends StatefulWidget {
  final List<Thumbnail> thumbnails;
  final int initialPage;

  // Actions for trailing
  final bool showImageActions;
  final Function deleteFunc;

  ImagesCarouselPage({@required this.thumbnails, this.initialPage,
    @required this.showImageActions, this.deleteFunc});

  @override
  State<StatefulWidget> createState() => ImagesCarouselPageState();
}

class ImagesCarouselPageState extends State<ImagesCarouselPage> {
  List<Thumbnail> thumbnailsState;
  int currPage;

  @override
  void initState() {
    super.initState();
    thumbnailsState = widget.thumbnails;
    currPage = widget.initialPage ?? 0;
  }

  void afterDelete() {
    setState(() {
      thumbnailsState.removeAt(currPage);
      currPage = max(currPage - 1, 0);
      if (thumbnailsState.isEmpty) Navigator.of(context).pop(); // pop when delete last image
    });
  }

  void switchPage(int idx) => setState(() {currPage = idx;});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: Icon(Icons.close),
          color: Colors.grey,
          onPressed: () => Navigator.of(context).pop(),
        ),
        trailing: widget.showImageActions ? IconButton(
          icon: Icon(Icons.more_vert),
          color: Colors.grey,
          onPressed: () {
            if (Platform.isAndroid) {
              showMaterialModalBottomSheet(
                context: context,
                builder: (_) => BottomModalContent(
                  deleteText: "이미지 삭제",
                  deleteDetailText: "해당 이미지를 정말 삭제하시겠습니까?",
                  deleteFunc: () async {
                    await widget.deleteFunc(imageId: thumbnailsState[currPage].id)
                      .then((successful) {
                        if (successful) {
                          Navigator.of(context).pop(); // pop Modal Bottom Content
                          afterDelete();
                        }
                    });
                  }
                )
              );
            } else {
              showCupertinoModalBottomSheet(
                context: context,
                builder: (_) => BottomModalContent(
                    deleteText: "이미지 삭제",
                    deleteDetailText: "해당 이미지를 정말 삭제하시겠습니까?",
                    deleteFunc: () async {
                      await widget.deleteFunc(imageId: thumbnailsState[currPage].id)
                        .then((successful) {
                          print(successful);
                          if (successful) {
                            Navigator.of(context).pop(); // pop Modal Bottom Content
                            afterDelete();
                          }
                      });
                    }
                )
              );
            }
          },
        ) : null,
      ),
      body: CarouselSlider(
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 1,
          enableInfiniteScroll: false,
          initialPage: currPage,
          onPageChanged: (idx, _) => switchPage(idx)
        ),
        items: [...thumbnailsState.map((e) => ImageExpanded(imagePath: e.path))]
      ),
    );
  }
}
