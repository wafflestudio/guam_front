import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:transparent_image/transparent_image.dart';
import '../../../../helpers/http_request.dart';

class ProjectCreateThumbnail extends StatefulWidget {
  final Map input;
  final bool isNewProject;

  ProjectCreateThumbnail(this.input, this.isNewProject);

  @override
  _ProjectCreateThumbnailState createState() => _ProjectCreateThumbnailState();
}

enum PhotoSelection { yes, no }

class _ProjectCreateThumbnailState extends State<ProjectCreateThumbnail> {
  PickedFile _imageFile;
  ImagePicker _picker = ImagePicker();
  PhotoSelection _character = PhotoSelection.yes;
  bool isThumbnailChanged = false;

  void saveProjectPhoto(image) {
    setState(() => widget.input["thumbnail"] = image);
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      widget.input['isThumbnailChanged'] = true;
      _imageFile = pickedFile;
      saveProjectPhoto(_imageFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      children: [
        ListTile(
          title: Text(
            '갤러리에서 찾기',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          selectedTileColor: Colors.white,
          leading: Radio<PhotoSelection>(
            value: PhotoSelection.yes,
            groupValue: _character,
            activeColor: Colors.white,
            onChanged: (PhotoSelection value) {
              setState(() => _character = value);
            },
          ),
        ),
        projectPicture(size),
        if (widget.isNewProject) ListTile(
          title: Text(
            '선택하지 않음',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
          leading: Radio<PhotoSelection>(
            value: PhotoSelection.no,
            groupValue: _character,
            activeColor: Colors.white,
            onChanged: (PhotoSelection value) {
              setState(() {
                _character = value;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget projectPicture(Size size) {
    if (_character.index == 0)
      return Container(
        padding: EdgeInsets.only(left: 70, bottom: 15),
        alignment: Alignment.centerLeft,
        child: InkWell(
          onTap: () {
            showModalBottomSheet(
              context: context, builder: ((builder) => bottomSheet(size))
            );
          },
          child: Container(
            width: 100,
            height: 100,
            child: widget.input['thumbnail'] == null
              ? _imageFile == null
                ? Icon(Icons.photo, color: Colors.white, size: 100)
                : Image(
                    image: FileImage(File(_imageFile.path)),
                    fit: BoxFit.fill,
                  )
              : widget.input['thumbnail'].runtimeType.toString() == 'PickedFile'
                ? _imageFile == null
                  ? Image(
                      image: FileImage(File(widget.input['thumbnail'].path)),
                      fit: BoxFit.fill,
                    )
                  : Image(
                      image: FileImage(File(_imageFile.path)),
                      fit: BoxFit.fill,
                    )
                : widget.input['thumbnail'].runtimeType.toString() == 'Thumbnail'
                  ? ClipRect(
                      child: FadeInImage(
                        placeholder: MemoryImage(kTransparentImage),
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          HttpRequest().s3BaseAuthority +
                              widget.input['thumbnail'].path,
                        )
                      ),
                    )
                  : Icon(Icons.photo, color: Colors.white, size: 100),
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.white),
              boxShadow: [
                BoxShadow(
                  spreadRadius: 2,
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.5),
                )
              ],
            ),
          ),
        )
      );
    else
      return Container();
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
            "프로젝트 대표 사진을 설정해주세요.",
            style: TextStyle(fontSize: 20),
          ),
          SizedBox(height: 25),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            TextButton.icon(
              icon: Icon(Icons.camera),
              onPressed: () => takePhoto(ImageSource.camera),
              label: Text("카메라"),
            ),
            TextButton.icon(
              icon: Icon(Icons.image),
              onPressed: () => takePhoto(ImageSource.gallery),
              label: Text("갤러리"),
            ),
          ])
        ],
      ),
    );
  }
}
