import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guam_front/helpers/http_request.dart';
import 'package:guam_front/helpers/pick_image.dart';
import 'package:guam_front/models/profile.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';

class MakeProfileImage extends StatefulWidget {
  final Function onTap;
  final Profile profile;

  MakeProfileImage({@required this.onTap, @required this.profile});

  @override
  _MakeProfileImageState createState() => _MakeProfileImageState();
}

class _MakeProfileImageState extends State<MakeProfileImage> {
  PickedFile _imageFile;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.fromLTRB(25, 20, 0, 0),
            child: Text("프로필 사진 선택",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black))),
        Center(
            child: Stack(
                children: [
          Container(
            width: 120,
            height: 120,
            child: _imageFile == null
                ? widget.profile.imageUrl == null
                    ? Icon(Icons.person, color: Colors.white, size: 100)
                    : ClipOval(
                        child: FadeInImage(
                            placeholder: MemoryImage(kTransparentImage),
                            fit: BoxFit.cover,
                            image: NetworkImage(HttpRequest().s3BaseAuthority +
                                widget.profile.imageUrl)),
                      )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: FileImage(File(_imageFile.path)),
                      fit: BoxFit.fill,
                    )),
            decoration: _imageFile == null && widget.profile.imageUrl == null
                ? BoxDecoration(boxShadow: [
                    BoxShadow(
                        blurRadius: 1,
                        color: Colors.black.withOpacity(0.5),
                        offset: Offset(0, 7))
                  ], shape: BoxShape.circle)
                : BoxDecoration(),
          ),
          Positioned(
              bottom: 0,
              right: 0,
              child: InkWell(
                  onTap: () {
                    showModalBottomSheet(
                        context: context,
                        builder: ((builder) => bottomSheet(size)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 1,
                      ),
                      gradient: LinearGradient(
                          colors: [
                            HexColor("4F34F3"),
                            HexColor("3EF7FF"),
                          ],
                          begin: FractionalOffset(1.0, 0.0),
                          end: FractionalOffset(0.0, 0.0),
                          stops: [0, 1],
                          tileMode: TileMode.clamp),
                    ),
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 30,
                    ),
                  )))
        ])),
      ],
    );
  }

  Widget bottomSheet(Size size) {
    return Container(
      height: 130,
      width: size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(
        children: <Widget>[
          Text(
            "프로필 사진을 설정해주세요.",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () {
                pickImage(type: 'camera').then((image) {
                  widget.onTap(image);
                  _imageFile = image;
                });
              },
              label: Text("카메라"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                pickImage(type: 'gallery').then((image) {
                  widget.onTap(image);
                  _imageFile = image;
                });
              },
              label: Text("갤러리"),
            ),
          ])
        ],
      ),
    );
  }
}
