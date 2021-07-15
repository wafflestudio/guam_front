import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class MakeProfileImage extends StatefulWidget {
  final Size size;

  MakeProfileImage(this.size);

  @override
  _MakeProfileImageState createState() => _MakeProfileImageState();
}

class _MakeProfileImageState extends State<MakeProfileImage> {
  final ImagePicker _picker = ImagePicker();
  PickedFile _imageFile;

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() => _imageFile = pickedFile);
  }

  @override
  Widget build(BuildContext context) {
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
            child: Stack(children: <Widget>[
          Container(
            width: 110,
            height: 110,
            child: _imageFile == null
                ? Icon(Icons.person, color: Colors.white, size: 100)
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image(
                      image: FileImage(File(_imageFile.path)),
                      fit: BoxFit.fill,
                    )),
            decoration: _imageFile == null
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
                        builder: ((builder) => bottomSheet(widget.size)));
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
                takePhoto(ImageSource.camera);
              },
              label: Text("카메라"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text("갤러리"),
            ),
          ])
        ],
      ),
    );
  }
}
