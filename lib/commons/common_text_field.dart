import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/foundation.dart';
import 'dart:io';
import '../helpers/pick_image.dart';
import 'image_thumbnail.dart';
import 'common_icon_button.dart';
import 'button_size_circular_progress_indicator.dart';

class CommonTextField extends StatefulWidget {
  final Function onTap;
  final dynamic editTarget;
  final bool allowImages;

  CommonTextField({@required this.onTap, this.editTarget, this.allowImages = true});

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final _threadTextFieldController = TextEditingController();
  final double maxImgSize = 80;
  final double deleteImgButtonRadius = 12;
  List<PickedFile> imageFileList = [];
  bool sending = false;

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

  void toggleSending() {
    setState(() {
      sending = !sending;
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isEdit = widget.editTarget != null;
    _threadTextFieldController.text = isEdit ? widget.editTarget.content : null;

    Future<void> send() async {
      toggleSending();

      try {
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
      } catch (e) {
        print(e);
      } finally {
        toggleSending();
      }
    }

    return ConstrainedBox(
      constraints: BoxConstraints(minHeight: 36),
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
                        maxLength: 250, // server DB 설정 상한을 넘지 않도록 클라에서는 250자로 제한합니다.
                        style: TextStyle(fontSize: 14),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    if (!isEdit && widget.allowImages) Row(
                      children: [
                        CommonIconButton(
                          icon: Icons.add_a_photo,
                          // 추후 갤러리에서만 아니라 카메라 촬영을 통해서 사진을 넣는 경우도 있어
                          // make_profile_image.dart 참고하시면 좋을 듯합니다!
                          onPressed: !sending
                              ? () {pickImage(type: 'gallery').then((img) => setImageFile(img));}
                              : null,
                        ),
                        Padding(padding: EdgeInsets.only(right: 10))
                      ],
                    ),
                    !sending ? CommonIconButton(
                      icon: Icons.send_outlined,
                      onPressed: !sending ? send : null
                    )
                    : ButtonSizeCircularProgressIndicator()
                  ],
                )
              ],
            ),
          ),
      ),
    );
  }
}
