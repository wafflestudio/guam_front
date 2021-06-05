import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guam_front/commons/app_bar.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

class CreateProjectBoardThree extends StatefulWidget {
  const CreateProjectBoardThree({Key key}) : super(key: key);

  @override
  _CreateProjectBoardThreeState createState() =>
      _CreateProjectBoardThreeState();
}

enum PhotoSelection { yes, no }

class _CreateProjectBoardThreeState extends State<CreateProjectBoardThree> {
  final isSelected = <bool>[false, false, false];
  final positions = <String>['백엔드', '프론트엔드', '디자이너'];
  Map input = {'myPosition': [], 'projectPhoto': ''};
  PickedFile _imageFile;
  final ImagePicker _picker = ImagePicker();
  PhotoSelection _character = PhotoSelection.yes;

  void _saveMyPosition(idx) {
    setState(() {
      input["myPosition"] = positions[idx];
    });
  }

  void _saveProjectPhoto(image) {
    setState(() {
      input["projectPicture"] = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(
        title: '프로젝트 만들기',
        leading: Back(),
      ),
      body: Padding(
          padding: EdgeInsets.only(top: 5),
          child: ProjectCreateContainer(
            content: Column(
              children: [
                Container(
                  alignment: Alignment.center,
                  child: Container(
                    width: 100,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '3. 나의 포지션 선택',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: HexColor("6B70AA"),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: myPosition(),
                ),
                Container(
                  padding: EdgeInsets.only(top: 40, left: 30, bottom: 10),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    '4. 프로젝트 사진 선택',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(
                    unselectedWidgetColor: Colors.white,
                  ),
                  child: Column(
                    children: <Widget>[
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
                            setState(() {
                              _character = value;
                            });
                          },
                        ),
                      ),
                      myProjectPicture(context, size, _character),
                      ListTile(
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
                  ),
                ),
                Expanded(
                    child: Align(
                        alignment: FractionalOffset.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Back(),
                            Container(
                              padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
                              child: InkWell(
                                onTap: () {},
                                child: Container(
                                  alignment: Alignment.center,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  height: 60,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1.5,
                                      color: Colors.white24,
                                    ),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Text(
                                    '생성',
                                    style: TextStyle(
                                        fontSize: 18, color: Colors.grey),
                                  ),
                                ),
                              ),
                            )
                          ],
                        ))),
                ProjectStatus(totalPage: 3, currentPage: 3),
              ],
            ),
          )),
    );
  }

  Widget myPosition() {
    return ToggleButtons(
      fillColor: HexColor("4694F9").withOpacity(0.5),
      borderColor: Colors.white,
      selectedBorderColor: Colors.white,
      borderRadius: BorderRadius.circular(10),
      borderWidth: 0.3,
      constraints: BoxConstraints(minWidth: 120, minHeight: 40),
      isSelected: isSelected,
      onPressed: (idx) {
        setState(() {
          for (int i = 0; i < isSelected.length; i++) {
            isSelected[i] = i == idx;
          }
          _saveMyPosition(idx);
        });
      },
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '백엔드',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '프론트엔드',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 5),
          child: Text(
            '디자이너',
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget myProjectPicture(
      BuildContext context, Size size, PhotoSelection character) {
    if (_character.index == 0)
      return Container(
          padding: EdgeInsets.only(left: 70, bottom: 15),
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                  context: context, builder: ((builder) => bottomSheet(size)));
            },
            child: Container(
              width: 100,
              height: 100,
              child: _imageFile == null
                  ? Icon(Icons.photo, color: Colors.white, size: 100)
                  : Image(
                      image: FileImage(File(_imageFile.path)),
                      fit: BoxFit.fill,
                    ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.white),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 2,
                      blurRadius: 10,
                      color: Colors.black.withOpacity(0.5))
                ],
              ),
            ),
          ));
    if (_character.index == 1) return Container();
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

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
      _saveProjectPhoto(_imageFile);
    });
  }
}
