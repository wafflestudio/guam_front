import 'dart:io';

import 'package:flutter/material.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_page_one.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_description.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_period.dart';
import 'package:guam_front/screens/projects/creation/page_one/project_create_title.dart';
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
    'period': -1,
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

    print(input);

    return Scaffold(
        appBar: CustomAppBar(
          title: '프로젝트 만들기',
          leading: Back(),
        ),
        body: Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            padding: EdgeInsets.only(top: 5),
            child: ProjectCreateContainer(
              content: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (_currentPage == 1) ProjectCreatePageOne(
                          input, periodSelected, _projectNameController,
                          _projectDescriptionController,),
                        if (_currentPage == 2) createProjectPageTwo(
                            _filterOptions),
                        if (_currentPage == 3)
                          createProjectPageThree(),
                        Column(
                          children: [
                            Container(
                              color: Colors.transparent,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  if (_currentPage == 1) nextPage(),
                                  if (_currentPage == 2)
                                    Row(children: [previousPage(), nextPage()]),
                                  if (_currentPage == 3)
                                    Row(
                                      children: [
                                        previousPage(),
                                        savePage(context)
                                      ],
                                    )
                                ],
                              ),
                            ),
                            ProjectStatus(
                                totalPage: 3, currentPage: _currentPage)
                          ],
                        )
                      ])),
            )));
  }

  // Page 이동
  Widget previousPage() {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: InkWell(
          onTap: () {
            setState(() {
              _currentPage -= 1;
            });
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery
                .of(context)
                .size
                .width * 0.45,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.white24,
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
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '이전',
              style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ));
  }

  Widget nextPage() {
    return (_currentPage == 1 &&
        input['title'] != '' &&
        input['period'] != -1 &&
        input['description'] != ''
        ? Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: InkWell(
            onTap: () {
              setState(() {
                _currentPage += 1;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: (_currentPage != 1
                  ? MediaQuery
                  .of(context)
                  .size
                  .width * 0.45
                  : MediaQuery
                  .of(context)
                  .size
                  .width * 0.9),
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.white24,
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
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '다음',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )))
        : (_currentPage == 2 &&
        input['백엔드']['stack'] != '' &&
        input['프론트엔드']['stack'] != '' &&
        input['디자이너']['stack'] != ''
        ? Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: InkWell(
            onTap: () {
              setState(() {
                _currentPage += 1;
              });
            },
            child: Container(
              alignment: Alignment.center,
              width: (_currentPage != 1
                  ? MediaQuery
                  .of(context)
                  .size
                  .width * 0.45
                  : MediaQuery
                  .of(context)
                  .size
                  .width * 0.9),
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.white24,
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
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text('다음',
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.bold)),
            )))
        : Container(
      padding: MediaQuery
          .of(context)
          .viewInsets
          .bottom > 0
          ? EdgeInsets.fromLTRB(5, 10, 5, 10)
          : EdgeInsets.fromLTRB(5, 60, 5, 20),
      child: Container(
        alignment: Alignment.center,
        width: (_currentPage != 1
            ? MediaQuery
            .of(context)
            .size
            .width * 0.45
            : MediaQuery
            .of(context)
            .size
            .width * 0.9),
        height: 60,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1.5,
            color: Colors.white24,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Text('다음',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey,
            )),
      ),
      // )
    )));
  }

  Widget savePage(BuildContext context) {
    Future createProject(dynamic body) async {
      return await widget.projectProvider
          .createProject(body)
          .then((successful) {
        Navigator.pop(context);
        widget.projectProvider.fetchProjects();
        return successful;
      });
    }

    return (_currentPage == 3 && input['myPosition'] != ''
        ? Container(
      padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
      child: InkWell(
        onTap: () {
          final projectInfo = {
            "title": input['title'],
            "due": input['period'],
            "description": input['description'],
            "backLeftCnt": input['백엔드']['headcount'],
            "designLeftCnt": input['디자이너']['headcount'],
            "frontLeftCnt": input['프론트엔드']['headcount'],
            "myPosition": input['myPosition'],
            "thumbnail": input['thumbnail'],
            "techStackIds": [
              {
                "first": setTechStackIdx(input['백엔드']['stack'], '백엔드'),
                "second": "BACKEND"
              },
              {
                "first":
                setTechStackIdx(input['프론트엔드']['stack'], '프론트엔드'),
                "second": "FRONTEND"
              },
              {
                "first": setTechStackIdx(input['디자이너']['stack'], '디자이너'),
                "second": "DESIGNER"
              }
            ]
          };
          createProject(projectInfo);
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.45,
          height: 60,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1.5,
              color: Colors.white24,
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
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            '생성',
            style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    )
        : Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery
              .of(context)
              .size
              .width * 0.45,
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
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
        )));
  }

  // Page 1
  // Widget createProjectPageOne() {
  //   return Container(
  //     child: Column(
  //       children: [
  //         Container(
  //           alignment: Alignment.center,
  //           child: Container(
  //             width: 100,
  //             height: 5,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(10),
  //             ),
  //           ),
  //         ),
  //         Container(
  //           padding: EdgeInsets.only(top: 20, left: 30, bottom: 10),
  //           alignment: Alignment.centerLeft,
  //           child: Text(
  //             '1. 프로젝트 아웃라인',
  //             style: TextStyle(
  //               fontSize: 24,
  //               color: Colors.white,
  //               fontWeight: FontWeight.bold,
  //             ),
  //           ),
  //         ),
  //         ProjectCreateTitle(input, _projectNameController),
  //         ProjectCreatePeriod(input, periodSelected),
  //         ProjectCreateDescription(input, _projectDescriptionController),
  //       ],
  //     ),
  //   );
  // }

  // Page 2
  Widget createProjectPageTwo(Map<dynamic, List<dynamic>> _filterOptions) {
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
            '2. 인원 및 스택 구성',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        pageTwoFilter(_filterOptions),
      ],
    );
  }

  Widget pageTwoFilter(Map<dynamic, List<dynamic>> filterOptions) {
    return Column(
      children: [
        Container(
            padding: const EdgeInsets.fromLTRB(3, 10, 10, 10),
            decoration: BoxDecoration(
              border: Border.all(color: HexColor("979797")),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Row(children: [
                  ...filterOptions.entries.map((e) =>
                      CreateFilterChip(
                          content: e.key,
                          display: e.key,
                          selected: selectedKey == e.key,
                          selectKey: selectKey,
                          filterValues: e.value))
                ]),
                if (selectedKey != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(
                          "인원",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 20),
                          child: headCounter()),
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                        child: Text(
                          "기술 스택",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Wrap(
                          children: [
                            ...filterValues.map((e) =>
                                CreateFilterValueChip(
                                  content: e,
                                  selected: input[selectedKey]["stack"] == e,
                                  selectValue: selectValue,
                                ))
                          ],
                        ),
                      )
                    ],
                  ),
              ],
            )),
        Container(
            padding: EdgeInsets.only(top: 10, left: 5, bottom: 5),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 10, left: 10, bottom: 10),
                  child: Text(
                    '포지션',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
                position(filterOptions),
              ],
            )),
      ],
    );
  }

  Widget headCounter() {
    return Row(
      children: <Widget>[
        Container(
          width: 36.0,
          height: 36.0,
          child: RawMaterialButton(
            shape: CircleBorder(
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            elevation: 5.0,
            fillColor: Colors.white24,
            child: Icon(
              Icons.remove,
              color: Colors.white,
            ),
            onPressed: () =>
            {if (selectedKey != null) minusHeadcount(selectedKey)},
          ),
        ),
        Container(
          padding: EdgeInsets.all(15),
          child: Text(
            input[selectedKey]["headcount"].toString(),
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        Container(
          width: 36.0,
          height: 36.0,
          child: RawMaterialButton(
            shape: CircleBorder(
              side: BorderSide(color: Colors.white, width: 1.5),
            ),
            elevation: 5.0,
            fillColor: Colors.white24,
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () =>
            {
              if (selectedKey != null) addHeadcount(selectedKey),
            },
          ),
        ),
      ],
    );
  }

  Widget position(Map<dynamic, List<dynamic>> filterOptions) {
    return Container(
        width: MediaQuery
            .of(context)
            .size
            .width * 0.95,
        decoration: BoxDecoration(
          border: Border.all(color: HexColor("979797")),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(children: [
          if ((input["백엔드"]["stack"] == '') &
          (input["프론트엔드"]["stack"] == '') &
          (input["디자이너"]["stack"] == ''))
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(20),
              child: Text(
                "포지션을 선택하여 크루를 구성하세요.",
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          if ((input["백엔드"]["stack"] != '') ||
              (input["프론트엔드"]["stack"] != '') ||
              (input["디자이너"]["stack"] != ''))
            Wrap(
              children: [
                ...filterOptions.entries.map((e) =>
                (input[e.key]["stack"]
                    .toString() !=
                    '')
                    ? Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Text(
                            e.key.toString(),
                            style: TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            input[e.key.toString()]["stack"].toString(),
                            style: TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                          Text(
                            input[e.key.toString()]["headcount"].toString(),
                            style: TextStyle(
                                fontSize: 14, color: Colors.white),
                          ),
                        ]))
                    : Container())
              ],
            ),
        ]));
  }

  // Page 3
  Widget createProjectPageThree() {
    final Size size = MediaQuery
        .of(context)
        .size;

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
            minWidth: (MediaQuery
                .of(context)
                .size
                .width * 0.85) / 3,
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

  Widget myProjectPicture(BuildContext context, Size size,
      PhotoSelection character) {
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
      widget.stacksProvider.stacks.forEach((e) =>
      {
        if (techStack == e.name) {input[position]['id'] = e.id}
      });
    });
    return input[position]['id'];
  }
}
