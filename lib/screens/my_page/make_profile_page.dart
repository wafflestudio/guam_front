import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/commons/custom_app_bar.dart';
import 'package:guam_front/models/profile.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/profiles/profile_filter_value_chip.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../providers/user_auth/authenticate.dart';
import '../../mixins/toast.dart';
import 'make_profile_image.dart';
import 'save_profile_button.dart';

class MakeProfilePage extends StatefulWidget {
  final Stacks stacksProvider;
  final bool showAppBar;

  MakeProfilePage({this.stacksProvider, showAppBar}) : this.showAppBar = showAppBar ?? true;

  @override
  _MakeProfilePageState createState() => _MakeProfilePageState();
}

class _MakeProfilePageState extends State<MakeProfilePage> with Toast {
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _blogController = TextEditingController();
  final TextEditingController _githubIdController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  final isSelected = <bool>[false, false, false];
  // 추후 List<int>로 수정해야 함.
  List<String> selectedSkillsList = [];
  Map techStacksInfo = {
    '백엔드': <String>[],
    '프론트엔드': <String>[],
    '디자이너': <String>[],
  };
  String selectedKey;
  List<String> filterValues;
  Profile me;
  bool willUploadImage;
  PickedFile profileImage;

  bool saveBtnEnabled;
  bool requesting = false;

  @override
  void initState() {
    super.initState();
    me = context.read<Authenticate>().me;
    _nicknameController.text = me.nickname;
    _githubIdController.text = me.githubUrl;
    _blogController.text = me.blogUrl;
    _introductionController.text = me.introduction;
    willUploadImage = false;
    selectedSkillsList = List<String>.from(me.skills);
    checkSaveEnabled();
  }

  @override
  void dispose() {
    _nicknameController.dispose();
    _githubIdController.dispose();
    _blogController.dispose();
    _introductionController.dispose();
    super.dispose();
  }

  void checkSaveEnabled() {
    setState(() {
      saveBtnEnabled = _nicknameController.text != null && _nicknameController.text != "";
    });
  }

  void toggleRequesting() {
    setState(() {
      requesting = !requesting;
    });
  }

  void setImageFile(PickedFile val) {
    setState(() {
      willUploadImage = true;
      if (val != null) profileImage = val;
    });
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

  void selectPosition(idx) {
    setState(() {
      selectedKey = techStacksInfo.keys.toList()[idx];
    });
  }

  void validate() { // more validation logic is free to be added !!
    if (!Uri.tryParse(_blogController.text).isAbsolute && _blogController.text != '') {
      throw new Exception("웹사이트는 http 또는 https 형식으로 입력해주세요.");
    }
  }

  @override
  Widget build(BuildContext context) {
    var techStacks = {
      'BACKEND': <dynamic>[],
      'DESIGNER': <dynamic>[],
      'FRONTEND': <dynamic>[]
    };

    widget.stacksProvider.stacks
        .forEach((e) => techStacks[e.position].add({e.id: e.name}));

    techStacks['백엔드'] = techStacks.remove('BACKEND');
    techStacks['프론트엔드'] = techStacks.remove('FRONTEND');
    techStacks['디자이너'] = techStacks.remove('DESIGNER');

    final authProvider = context.read<Authenticate>();

    Future setProfile() async {
      toggleRequesting();
      try {
        validate();
        return await authProvider.setProfile(
          fields: {
            "nickname": _nicknameController.text,
            "blogUrl": _blogController.text,
            "githubUrl": _githubIdController.text,
            "introduction": _introductionController.text,
            "skills": selectedSkillsList,
            "willUploadImage": willUploadImage.toString(),
          },
          files: willUploadImage ? [File(profileImage.path)] : null,
        ).then((successful) async {
          if (successful) {
            await authProvider.getMyProfile();
            Navigator.pop(context);
          }
        });
      } catch (e) {
        showToast(success: false, msg: e.message);
      } finally {
        toggleRequesting();
      }
    }

    return Scaffold(
      appBar: widget.showAppBar ? CustomAppBar(title: "프로필 수정", leading: Back()) : null,
      body: DecoratedBox(
        decoration: BoxDecoration(
          image: DecorationImage(
            colorFilter: ColorFilter.mode(
              Colors.white.withOpacity(0.7), BlendMode.dstATop,
            ),
            image: AssetImage("assets/backgrounds/profile-bg-1.png"),
            fit: BoxFit.cover,
          )
        ),
        child: SingleChildScrollView(
          child: Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(height: 20),
              Container(color: Colors.grey),
              Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                MakeProfileImage(onTap: setImageFile, profile: me),
                _profileInfo(techStacks),
                // _authButton(setProfile)
                SaveProfileButton(
                  enabled: saveBtnEnabled,
                  requesting: requesting,
                  saveProfile: setProfile,
                )
              ]),
            ],
          ),
        )
      )
    );
  }

  Widget _profileInfo(Map<dynamic, List<dynamic>> techStacks) {
    return Container(
      padding: EdgeInsets.fromLTRB(15, 20, 15, 10),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _inputForm(
              textController: _nicknameController,
              label: '별명',
              hint: '닉네임을 입력하세요.',
              maxLines: 1,
              maxLength: 8,
              required: true,
              onTextChanged: checkSaveEnabled, // 필수 필드 체크
            ),
            _inputForm(
              image: 'assets/images/github-icon.png',
              textController: _githubIdController,
              label: 'GitHub ID',
              hint: 'GitHub ID를 입력하세요.',
              maxLines: 1,
              maxLength: 39, // github official maxLength
            ),
            _inputForm(
              image: 'assets/images/browser-icon.png',
              textController: _blogController,
              label: '웹사이트',
              hint: 'https://wafflestudio.com',
              maxLines: 1,
              maxLength: 100,
            ),
            _inputForm(
              textController: _introductionController,
              label: '자기소개',
              hint: '다른 사람들에게 나를 소개해보세요.',
              maxLines: 4,
              maxLength: 250,
            ),
            _techStacksFilter(techStacks)
          ],
        ),
      ),
    );
  }

  Widget _inputForm({String image, TextEditingController textController, String label,
    String hint, int maxLines, int maxLength, bool required = false, Function onTextChanged}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 3),
          child: Row(
            children: [
              if (image != null)
                Row(
                  children: [
                    Image(width: 20, image: AssetImage(image)),
                    Text(' '),
                  ],
                ),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                )
              ),
              if (required) Text(
                " *",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              )
            ],
          )
        ),
        Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: TextFormField(
            maxLines: maxLines,
            maxLength: maxLength,
            controller: textController,
            onChanged: (_) => onTextChanged(),
            style: TextStyle(fontSize: 14, color: Colors.black),
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.grey),
              ),
              hintText: hint,
              hintStyle: TextStyle(fontSize: 14, color: Colors.grey)
            ),
          ),
        )
      ]
    );
  }

  Widget _techStacksFilter(Map<dynamic, List<dynamic>> techStacks) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(left: 10, bottom: 3),
          child: Text("기술 스택",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black)
          )
        ),
        positionSelection(),
        if (selectedKey != null)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(left: 10),
                child: Container(
                  child: ProfileFilterValueChip(
                    techStacks[selectedKey],
                    (selectedList) {
                      setState(() => selectedSkillsList = selectedList);
                    },
                  ),
                )
              )
            ],
          ),
      ],
    );
  }

  Widget positionSelection() {
    return Container(
      padding: EdgeInsets.only(left: 10),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: ToggleButtons(
          fillColor: HexColor("85DC40"),
          borderColor: HexColor("000000").withOpacity(0.6),
          borderRadius: BorderRadius.circular(10),
          borderWidth: 0.5,
          constraints: BoxConstraints(
            minWidth: (MediaQuery.of(context).size.width * 0.85) / 3,
            minHeight: 40,
          ),
          isSelected: isSelected,
          onPressed: (idx) {
            setState(() {
              for (int i = 0; i < isSelected.length; i++) {
                isSelected[i] = i == idx;
              }
              selectPosition(idx);
            });
          },
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '백엔드',
                style: (selectedKey == '백엔드')
                  ? TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                  : TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '프론트엔드',
                style: (selectedKey == '프론트엔드')
                  ? TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                  : TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                '디자이너',
                style: (selectedKey == '디자이너')
                  ? TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    )
                  : TextStyle(fontSize: 14, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
