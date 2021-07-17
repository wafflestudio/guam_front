import 'package:flutter/material.dart';
import 'common_icon_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import '../helpers/pick_image.dart';
import '../commons/image_thumbnail.dart';
import 'dart:io';

class CommonTextField extends StatefulWidget {
  final Function onTap;

  CommonTextField({@required this.onTap});

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final _threadTextFieldController = TextEditingController();
  final double maxImgSize = 80;
  final double deleteImgButtonRadius = 12;
  List<PickedFile> imageFileList = [];

  @override
  void dispose() {
    _threadTextFieldController.dispose();
    super.dispose();
  }

  void setImageFile(PickedFile val) {
    setState(() {
      if (val != null) imageFileList.add(val);
    });
  }

  void deleteImageFile(int idx) {
    setState(() {
      imageFileList.removeAt(idx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: 36
      ),
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    children: [
                      if (imageFileList.isNotEmpty) Container(
                        constraints: BoxConstraints(maxHeight: maxImgSize + deleteImgButtonRadius),
                        margin: EdgeInsets.only(bottom: 10),
                        child: ListView.builder(
                          itemCount: imageFileList.length,
                          itemBuilder: (_, idx) => Stack(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: deleteImgButtonRadius, right: deleteImgButtonRadius),
                                child: ImageThumbnail(
                                    image: Image(
                                      image: FileImage(File(imageFileList[idx].path)),
                                      fit: BoxFit.fill,
                                    ),
                                    height: maxImgSize,
                                    width: maxImgSize
                                ),
                              ),
                              Positioned(
                                top: 0,
                                right: 0,
                                child: CommonIconButton(
                                  icon: Icons.remove_circle,
                                  iconColor: Colors.red,
                                  onPressed: () => deleteImageFile(idx),
                                ),
                              )
                            ],
                          ),
                          scrollDirection: Axis.horizontal,
                        ),
                      ),
                      TextField(
                        controller: _threadTextFieldController,
                        decoration: null,
                        maxLines: null,
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    CommonIconButton(
                      icon: Icons.add_a_photo,
                      onPressed: () async {
                        await pickImage().then((val) => setImageFile(val));
                      },
                    ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    CommonIconButton(
                      icon: Icons.send_outlined,
                      onPressed: () async {
                        await widget.onTap(
                          fields: {"content": _threadTextFieldController.text},
                          //files
                        ).then((successful) {
                          if (successful) {
                            _threadTextFieldController.clear();
                            FocusScope.of(context).unfocus();
                          }
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
      ),
    );
  }
}
