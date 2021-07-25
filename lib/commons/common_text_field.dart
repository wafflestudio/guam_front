import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../helpers/pick_image.dart';
import '../commons/image_thumbnail.dart';
import 'common_icon_button.dart';

class CommonTextField extends StatefulWidget {
  final Function onTap;
  final dynamic editTarget;

  CommonTextField({@required this.onTap, this.editTarget});

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
    imageFileList.clear();
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
    bool isEdit = widget.editTarget != null;
    _threadTextFieldController.text = isEdit ? widget.editTarget.content : null;

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
                    if (!isEdit) CommonIconButton(
                      icon: Icons.add_a_photo,
                      onPressed: () async => await pickImage().then((img) => setImageFile(img)),
                    ),
                    if (!isEdit) Padding(padding: EdgeInsets.only(right: 10)),
                    CommonIconButton(
                      icon: Icons.send_outlined,
                      onPressed: () async {
                        if (isEdit) {
                          await widget.onTap(
                            id: widget.editTarget.id,
                            fields: {"content": _threadTextFieldController.text},
                          ).then((successful) {
                            if (successful) {
                              _threadTextFieldController.clear();
                              FocusScope.of(context).unfocus();
                            }
                          });
                        } else {
                          await widget.onTap(
                            files: [...imageFileList.map((e) => File(e.path))],
                            fields: {"content": _threadTextFieldController.text},
                          ).then((successful) {
                            if (successful) {
                              imageFileList.clear();
                              _threadTextFieldController.clear();
                              FocusScope.of(context).unfocus();
                            }
                          });
                        }
                      }
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
