import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guam_front/commons/custom_app_bar.dart';
import 'package:guam_front/models/profile.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/my_page/profile_filter_chip.dart';
import 'package:guam_front/screens/my_page/profile_filter_value_chip.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/user_auth/authenticate.dart';
import 'package:provider/provider.dart';

class MakeProfilePage extends StatefulWidget {
  final Stacks stacksProvider;

  MakeProfilePage(this.stacksProvider);

  @override
  _MakeProfilePageState createState() => _MakeProfilePageState();
}

class _MakeProfilePageState extends State<MakeProfilePage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _blogController = TextEditingController();
  final TextEditingController _githubIdController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();

  Map techStacksInfo = {
    '백엔드': [],
    '프론트엔드': [],
    '디자이너': [],
  };
  String selectedKey;
  List<String> filterValues;

  PickedFile _imageFile;
  Profile me;

  @override
  void initState() {
    me = context.read<Authenticate>().me;
    _nicknameController.text = me.nickname;
    _githubIdController.text = me.githubUrl;
    _blogController.text = me.blogUrl;
    _introductionController.text = me.introduction;
    super.initState();
  }

  void selectKey(String key, List<String> value) {
    setState(() {
      selectedKey = selectedKey == key ? null : key;
      filterValues = value;
    });
  }

  void selectValue(String value) {
    setState(() => techStacksInfo[selectedKey].add(value));
  }

  @override
  Widget build(BuildContext context) {
    print(techStacksInfo);
    var techStacks = Map.fromIterable(
        List<dynamic>.from(
                widget.stacksProvider.stacks.map((stack) => stack.position))
            .toSet()
            .toList(),
        key: (v) => v,
        value: (v) => []);

    List<dynamic>.from(widget.stacksProvider.stacks.map((stack) => {
          {techStacks[stack.position].add(stack.name)}
        }));

    techStacks.keys.forEach(
        (key) => {techStacks[key] = List<String>.from(techStacks[key])});

    techStacksInfo.keys.forEach((key) =>
        {techStacksInfo[key] = List<String>.from(techStacksInfo[key])});

    techStacks['백엔드'] = techStacks['BACKEND'];
    techStacks['프론트엔드'] = techStacks['FRONTEND'];
    techStacks['디자이너'] = techStacks['DESIGNER'];
    techStacks.remove('UNKNOWN');
    techStacks.remove('BACKEND');
    techStacks.remove('FRONTEND');
    techStacks.remove('DESIGNER');

    final Size size = MediaQuery.of(context).size;
    final authProvider = context.read<Authenticate>();

    void setProfile(dynamic params) {
      authProvider.setProfile(params);
    }

    return Scaffold(
      appBar: CustomAppBar(title: "프로필 수정"),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(height: 20),
            Container(color: Colors.grey),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                imageProfile(context, size),
                _profileInfo(size, techStacks),
                _authButton(size, setProfile)
              ]),
            ],
          ),
        ));
  }

  Widget imageProfile(BuildContext context, Size size) {
    return Center(
        child: Stack(children: <Widget>[
      Container(
        width: 110,
        height: 110,
        child: _imageFile == null
            ? Icon(Icons.person, color: Colors.white, size: 100)
            : Image(
                image: FileImage(File(_imageFile.path)),
                fit: BoxFit.fill,
              ),
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
              blurRadius: 1,
              color: Colors.black.withOpacity(0.5),
              offset: Offset(0, 7))
        ], shape: BoxShape.circle),
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
    ]));
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

  void takePhoto(ImageSource source) async {
    final pickedFile = await _picker.getImage(source: source);
    setState(() => _imageFile = pickedFile);
  }

  Widget _profileInfo(Size size, Map<dynamic, List<dynamic>> techStacks) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _inputForm(_nicknameController, '닉네임', '닉네임을 입력하세요.', 1),
            _inputForm(
                _githubIdController, 'GitHub ID', 'GitHub ID를 입력하세요.', 1),
            _inputForm(_blogController, '웹사이트', 'Website', 1),
            _inputForm(
                _introductionController, '자기 소개', '다른 사람들에게 나를 소개해보세요.', 3),
            _techStacksFilter(techStacks)
          ],
        ),
      ),
    );
  }

  Widget _inputForm(TextEditingController textController, String label,
      String hint, int maxLines) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(
          padding: EdgeInsets.only(left: 10, bottom: 3),
          child: Text(label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ))),
      Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 20),
        child: TextFormField(
          maxLines: maxLines,
          controller: textController,
          style: TextStyle(fontSize: 14, color: Colors.black),
          decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.grey,
                ),
              ),
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey)),
          validator: (String value) {
            if (value.isEmpty) {
              return "입력하지 않았습니다.";
            }
            if (value.length > 2) {
              return "최소한 두 글자 이상이어야 합니다.";
            }
            return null;
          },
        ),
      )
    ]);
  }

  Widget _techStacksFilter(Map<dynamic, List<dynamic>> techStacks) {
    List<String> selectedReportList = [];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            padding: EdgeInsets.only(left: 10, bottom: 3),
            child: Text("기술 스택",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ))),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          ...techStacks.entries.map((e) => ProfileFilterChip(
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
                  padding: EdgeInsets.only(left: 10),
                  child: Container(
                    child: TechStacksMultiSelectChip(
                      techStacks[selectedKey],
                      onSelectionChanged: (selectedList) {
                        setState(() {
                          selectedReportList = selectedList;
                        });
                      },
                    ),
                  ))
            ],
          ),
      ],
    );
  }

  Widget _authButton(Size size, Function setProfile) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 10, 5, 20),
      child: InkWell(
        onTap: () {
          final keyMap = {
            "nickname": _nicknameController.text,
            "blogUrl": _blogController.text,
            "githubUrl": _githubIdController.text,
            "introduction": _introductionController.text,
          };
          setProfile(keyMap);
        },
        child: Container(
          alignment: Alignment.center,
          width: MediaQuery.of(context).size.width * 0.85,
          height: 50,
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
            '저장하기',
            style: TextStyle(
                fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
