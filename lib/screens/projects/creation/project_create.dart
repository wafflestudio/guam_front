import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guam_front/commons/page_status.dart';
import 'package:guam_front/commons/project_create_container.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../../../commons/app_bar.dart';
import '../../../commons/back.dart';
import 'create_filter_chip.dart';
import 'create_filter_value_chip.dart';

class CreateProjectScreen extends StatefulWidget {
  final Map periodOptions = {1: '주', 2: '월'};
  final Map filterOptions = {
    '백엔드': [
      '상관 없음',
      'SpringBoot',
      'JPA',
      'Django',
      'express',
      'Ruby on Rails',
      'node.js',
      'Laravel',
    ],
    '프론트엔드': [
      '상관 없음',
      'React JS',
      'React TS',
      'Swift',
      'Android',
      'React Native',
      'Flutter',
      'Angular',
    ],
    '디자이너': ['상관 없음', 'Adobe XD', 'Figma', 'Sketch']
  };

  @override
  _CreateProjectScreenState createState() => _CreateProjectScreenState();
}

enum PhotoSelection { yes, no }

class _CreateProjectScreenState extends State<CreateProjectScreen> {
  String selectedKey;
  List<String> filterValues;
  Map input = {
    'title': '',
    'period': 1,
    'description': '',
    '백엔드': {'stack': '', 'headcount': 0},
    '프론트엔드': {'stack': '', 'headcount': 0},
    '디자이너': {'stack': '', 'headcount': 0},
    'myPosition': [],
    'projectPhoto': '',
  };
  Map positions = {
    '백엔드': {'stack': '', 'headcount': 0},
    '프론트엔드': {'stack': '', 'headcount': 0},
    '디자이너': {'stack': '', 'headcount': 0},
  };
  final _projectNameController = TextEditingController();
  final _projectDescriptionController = TextEditingController();
  final isSelected = <bool>[false, false, false];
  int _currentPage = 1;
  int _value = 1;
  double _period = 1;
  PickedFile _imageFile;
  ImagePicker _picker = ImagePicker();
  PhotoSelection _character = PhotoSelection.yes;

  void saveTitle(_projectName) {
    setState(() {
      input["title"] = _projectName;
    });
  }

  void savePeriod(_projectPeriod) {
    setState(() {
      input["period"] = _projectPeriod;
    });
  }

  void saveDescription(_projectDescription) {
    setState(() {
      input["description"] = _projectDescription;
    });
  }

  void addPage(currentPage) {
    setState(() {
      if (currentPage < 4) {
        input["currentPage"] = currentPage;
      }
    });
  }

  void minusPage(currentPage) {
    setState(() {
      input["currentPage"] = currentPage;
    });
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
      input["myPosition"] = positions.keys.toList()[idx];
    });
  }

  void saveProjectPhoto(image) {
    setState(() {
      input["projectPicture"] = image;
    });
  }

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() {
      _imageFile = pickedFile;
      saveProjectPhoto(_imageFile);
    });
  }

  @override
  Widget build(BuildContext context) {
    print(input);
    return Scaffold(
        appBar: appBar(
          title: '프로젝트 만들기',
          leading: Back(),
        ),
        body: Padding(
            padding: EdgeInsets.only(top: 5),
            child: ProjectCreateContainer(
                content: Container(
              child: Column(children: [
                (_currentPage == 1 ? pageOne() : Container()),
                (_currentPage == 2 ? pageTwo() : Container()),
                (_currentPage == 3 ? pageThree() : Container()),
                Expanded(
                    child: Align(
                  alignment: FractionalOffset.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      (_currentPage == 1 ? nextPage() : Container()),
                      (_currentPage == 2
                          ? Row(
                              children: [previousPage(), nextPage()],
                            )
                          : Container()),
                      (_currentPage == 3
                          ? Row(
                              children: [previousPage(), savePage()],
                            )
                          : Container())
                    ],
                  ),
                )),
                ProjectStatus(totalPage: 3, currentPage: _currentPage)
              ]),
            ))));
  }

  // Page 이동
  Widget previousPage() {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: InkWell(
          onTap: () {
            _currentPage -= 1;
            minusPage(_currentPage);
          },
          child: Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width * 0.45,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '이전',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        ));
  }

  Widget nextPage() {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: InkWell(
          onTap: () {
            _currentPage += 1;
            minusPage(_currentPage);
          },
          child: Container(
            alignment: Alignment.center,
            width: (_currentPage != 1
                ? MediaQuery.of(context).size.width * 0.45
                : MediaQuery.of(context).size.width * 0.9),
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              '다음',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        ));
  }

  Widget savePage() {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
      child: InkWell(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.45,
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
        ),
      ),
    );
  }

  // Page 1
  Widget pageOne() {
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
            '1. 프로젝트 아웃라인',
            style: TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        projectTitle(_projectNameController),
        projectPeriod(),
        projectDescription(_projectDescriptionController),
      ],
    );
  }

  Widget projectTitle(TextEditingController _nameController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 30, bottom: 15),
            child: Text('제목',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ))),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 50,
          child: TextFormField(
            onChanged: (_projectName) {
              saveTitle(_projectName);
            },
            controller: _nameController,
            style: TextStyle(fontSize: 14, color: Colors.white),
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white24,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: "프로젝트 이름을 입력하세요.",
                hintStyle: TextStyle(fontSize: 14, color: Colors.white)),
            validator: (String value) {
              if (value.isEmpty) {
                return "프로젝트 이름을 입력하지 않았습니다.";
              }
              if (value.length > 2) {
                return "프로젝트 이름은 최소한 두 글자 이상이어야 합니다.";
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  Widget projectPeriod() {
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                padding: EdgeInsets.only(left: 30),
                child: Text('진행 기간',
                    style: TextStyle(fontSize: 18, color: Colors.white))),
            Row(
              children: [
                Container(
                    padding: EdgeInsets.only(left: 7),
                    width: MediaQuery.of(context).size.width * 0.65,
                    child: SliderTheme(
                      data: SliderThemeData(
                          trackHeight: 1.5,
                          activeTrackColor: HexColor('7EE7E6'),
                          thumbColor: Colors.white,
                          inactiveTrackColor: Colors.white24,
                          activeTickMarkColor: Colors.white,
                          valueIndicatorColor: Colors.white,
                          valueIndicatorTextStyle:
                              TextStyle(color: Colors.black, fontSize: 14),
                          thumbShape:
                              RoundSliderThumbShape(enabledThumbRadius: 12)),
                      child: Slider(
                          min: 1,
                          max: 10,
                          divisions: 9,
                          value: _period,
                          onChanged: (_newPeriod) {
                            setState(() {
                              _period = _newPeriod;
                              savePeriod(_newPeriod);
                            });
                          }),
                    )),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.5,
                          color: Colors.white24,
                        ),
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        _period.round().toString(),
                        style: TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ),
                    Wrap(children: [
                      ...widget.periodOptions.entries.map((e) => FilterChip(
                            label: Text(
                              '${e.value}',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white),
                            ),
                            showCheckmark: false,
                            side: BorderSide(color: Colors.white, width: 0.5),
                            padding: EdgeInsets.symmetric(
                                horizontal: 2, vertical: 1),
                            selected: _value == e.key,
                            selectedColor: HexColor('4694F9'),
                            onSelected: (bool selected) {
                              setState(() => _value = selected ? e.key : null);
                              input['period'] += e.value;
                            },
                          ))
                    ])
                  ],
                )
              ],
            )
          ],
        ));
  }

  Widget projectDescription(TextEditingController _descriptionController) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 30, top: 20, bottom: 13),
            child: Text('설명',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ))),
        Container(
          padding: EdgeInsets.only(left: 20, right: 20),
          height: 100,
          child: TextFormField(
            onChanged: (_projectDescription) {
              setState(() {
                saveDescription(_projectDescription);
              });
            },
            controller: _descriptionController,
            style: TextStyle(fontSize: 14, color: Colors.white),
            maxLines: 6,
            decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white24,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
                hintText: "프로젝트 설명란입니다.",
                hintStyle: TextStyle(fontSize: 14, color: Colors.white)),
            validator: (String value) {
              if (value.isEmpty) {
                return "프로젝트 설명을 입력하지 않았습니다.";
              }
              if (value.length > 10) {
                return "프로젝트 설명은 최소한 열 글자 이상이어야 합니다.";
              }
              return null;
            },
          ),
        )
      ],
    );
  }

  // Page 2
  Widget pageTwo() {
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
        pageTwoFilter(),
      ],
    );
  }

  Widget pageTwoFilter() {
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
                ...widget.filterOptions.entries.map((e) => CreateFilterChip(
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
                          ...filterValues.map((e) => CreateFilterValueChip(
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
          ),
        ),
        Container(
            padding: EdgeInsets.only(top: 10, left: 5, bottom: 15),
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
                position(),
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
            onPressed: () => {
              if (selectedKey != null) addHeadcount(selectedKey),
            },
          ),
        ),
      ],
    );
  }

  Widget position() {
    return Container(
        width: MediaQuery.of(context).size.width * 0.95,
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
                ...positions.entries.map((e) => (input[e.key]["stack"]
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
  Widget pageThree() {
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
}
