import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/previous_page.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:guam_front/commons/save_page.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_page_one.dart';
import 'package:guam_front/screens/projects/creation/page_two/project_create_page_two.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';

import '../../../commons/back.dart';
import '../../../commons/custom_app_bar.dart';
import 'create_filter_chip.dart';
import 'create_filter_value_chip.dart';

class CreateProjectScreen extends StatefulWidget {
  final Projects projectProvider;
  final Stacks stacksProvider;

  CreateProjectScreen(this.projectProvider, this.stacksProvider);

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

enum PhotoSelection { yes, no }

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  String selectedKey;
  List<String> filterValues;
  Map input = {
    'title': '',
    'period': 0,
    'description': '',
    '백엔드': {'id': 0, 'stack': '', 'headcount': 0},
    '프론트엔드': {'id': 0, 'stack': '', 'headcount': 0},
    '디자이너': {'id': 0, 'stack': '', 'headcount': 0},
    'myPosition': '',
    'thumbnail': '',
  };
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final periodSelected = <bool>[false, false, false, false];
  final positionSelected = <bool>[false, false, false];
  int _currentPage = 1;
  PickedFile _imageFile;
  ImagePicker _picker = ImagePicker();
  PhotoSelection _character = PhotoSelection.yes;

  @override
  Widget build(BuildContext context) {
    var _filterOptions = {
      'BACKEND': <String>[],
      'DESIGNER': <String>[],
      'FRONTEND': <String>[]
    };

    widget.stacksProvider.stacks
        .forEach((e) => _filterOptions[e.position].add(e.name));

    _filterOptions['백엔드'] = _filterOptions.remove('BACKEND');
    _filterOptions['프론트엔드'] = _filterOptions.remove('FRONTEND');
    _filterOptions['디자이너'] = _filterOptions.remove('DESIGNER');

    Future createProject(dynamic body) async {
      return await widget.projectProvider
          .createProject(body)
          .then((successful) {
        Navigator.pop(context);
        widget.projectProvider.fetchProjects();
        return successful;
      });
    }

    void goToNextPage() {
      setState(() {
        _currentPage++;
      });
    }

    void goToPreviousPage() {
      setState(() {
        _currentPage--;
      });
    }

    print(input);
    return Scaffold(
        appBar: CustomAppBar(
          title: '프로젝트 만들기',
          leading: Back(),
        ),
        body: Container(
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 5),
            child: ProjectCreateContainer(
              content: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                    if (_currentPage == 1)
                      ProjectCreatePageOne(
                          input,
                          periodSelected,
                          _projectNameController,
                          _projectDescriptionController,
                          goToNextPage),
                    if (_currentPage == 2)
                      ProjectCreatePageTwo(input, _filterOptions, goToNextPage, goToPreviousPage),
                    if (_currentPage == 3) createProjectPageThree(),
                    Column(
                      children: [
                        Container(
                          color: Colors.transparent,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // if (_currentPage != 1)
                              //   PreviousPage(
                              //     page: _currentPage,
                              //     onTap: () {
                              //       setState(() {
                              //         _currentPage--;
                              //       });
                              //     },
                              //   ),
                              if (_currentPage == 3)
                                SavePage(
                                  page: _currentPage,
                                  onTap: () {
                                    setState(() {});
                                  },
                                ),
                            ],
                          ),
                        ),
                        ProjectStatus(totalPage: 3, currentPage: _currentPage)
                      ],
                    )
                  ])),
            )));
  }

  // Page 3
  Widget createProjectPageThree() {
    final Size size = MediaQuery.of(context).size;

    return Column(
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
      ],
    );
  }

  Widget myPosition() {
    return Container(
      child: ToggleButtons(
        fillColor: HexColor("4694F9").withOpacity(0.5),
        borderColor: Colors.white,
        selectedBorderColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        borderWidth: 0.3,
        constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width * 0.85) / 3,
            minHeight: 40),
        isSelected: positionSelected,
        onPressed: (idx) {
          setState(() {
            for (int i = 0; i < positionSelected.length; i++) {
              positionSelected[i] = i == idx;
            }
            saveMyPosition(idx);
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
      ),
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

  void addHeadcount(tech) {
    setState(() {
      input[tech]["headcount"]++;
    });
  }

  void minusHeadcount(tech) {
    setState(() {
      if (input[tech]["headcount"] > 0) input[tech]["headcount"]--;
    });
  }

  void selectKey(String key, List<String> value) {
    setState(() {
      selectedKey = selectedKey == key ? null : key;
      filterValues = value;
    });
  }

  void selectValue(String value) {
    setState(() => input[selectedKey]["stack"] = value);
  }

  void saveMyPosition(idx) {
    setState(() {
      input["myPosition"] = ['BACKEND', 'FRONTEND', 'DESIGNER'][idx];
    });
  }

  void saveProjectPhoto(image) {
    setState(() {
      input["thumbnail"] = image;
    });
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
      saveProjectPhoto(_imageFile);
    });
  }

  setTechStackIdx(String techStack, String position) {
    setState(() {
      widget.stacksProvider.stacks.forEach((e) => {
            if (techStack == e.name) {input[position]['id'] = e.id}
          });
    });
    return input[position]['id'];
  }
}
