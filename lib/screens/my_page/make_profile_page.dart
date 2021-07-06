import 'dart:io';
import 'package:flutter/material.dart';
import 'package:guam_front/commons/custom_app_bar.dart';
import 'package:guam_front/models/profile.dart';
import 'package:image_picker/image_picker.dart';
import '../../providers/user_auth/authenticate.dart';
import 'package:provider/provider.dart';

class MakeProfilePage extends StatefulWidget {
  @override
  _MakeProfilePageState createState() => _MakeProfilePageState();
}

class _MakeProfilePageState extends State<MakeProfilePage> {
  final ImagePicker _picker = ImagePicker();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _blogController = TextEditingController();
  final TextEditingController _githubIdController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  final TextEditingController _hashtagController = TextEditingController();

  PickedFile _imageFile;
  Profile me;

  @override
  void initState() {
    me = context.read<Authenticate>().me;
    _nicknameController.text = me.nickname;
    _blogController.text = me.blogUrl;
    _githubIdController.text = me.githubUrl;
    _introductionController.text = me.introduction;
    //_hashtagController.text = me.skills;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                Stack(
                  children: [
                    _inputForm(size),
                    _authButton(size, setProfile)
                  ],
                ),
              ]
            ),
          ],
        ),
      )
    );
  }

  Widget imageProfile(BuildContext context, Size size) {
    return Center(
      child: Stack(children: <Widget>[
        Container(
          width: 150,
          height: 170,
          child: _imageFile == null
              ? Icon(Icons.person, color: Colors.white, size: 130)
              : Image(image: FileImage(File(_imageFile.path)), fit: BoxFit.fill,),
          decoration: BoxDecoration(
            border: Border.all(width: 3, color: Colors.white),
            boxShadow: [
              BoxShadow(
                spreadRadius: 2,
                blurRadius: 10,
                color: Colors.black.withOpacity(0.5)
              )
            ],
            shape: BoxShape.circle
          ),
        ),
        Positioned(
          bottom: 15,
          right: 0,
          child: InkWell(
            onTap: () {
              showModalBottomSheet(
                context: context,
                builder: ((builder) => bottomSheet(size))
              );
              },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                )
              ),
              child: Icon(
              Icons.camera_alt_sharp,
              color: Colors.black,
              size: 30,
            ),
            )
          )
        )
      ])
    );
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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

  Widget _inputForm(Size size){
    return Padding(
      padding: EdgeInsets.all(size.width*0.05),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)
        ),
        elevation: 15,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 12, right: 16, top: 12, bottom: 32),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextFormField(
                  controller: _nicknameController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: "닉네임",
                  ),
                  validator: (String value){
                    if(value.isEmpty){
                      return "Please write your nickname.";
                    }
                    if(value.length>2){
                      return "A nickname should be at least 2 letters.";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _blogController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.public),
                    labelText: "지식블로그",
                  ),
                ),
                TextFormField(
                  controller: _githubIdController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.desktop_mac),
                    labelText: "GitHub 아이디",
                  ),
                ),
                Container(height: 15,),
                TextField(
                  maxLines: 3,
                  controller: _introductionController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.message),
                    border: OutlineInputBorder(),
                    hintText: '나를 소개해주세요.',
                    labelText: '자기소개',
                  ),
                ),
                Container(height: 15,),
                TextField(
                  maxLines: 3,
                  controller: _hashtagController,
                  decoration: InputDecoration(
                    icon: Icon(Icons.tag),
                    border: OutlineInputBorder(),
                    hintText: '#Flutter #SpringBoot #k8s',
                    labelText: '관심분야',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _authButton(Size size, Function setProfile){
    return Positioned(
      left: size.width*0.15,
      right: size.width*0.15,
      bottom: 0,
      child: RaisedButton(
        child: Text("저장"),
        color: Colors.blue,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15)),
        onPressed: () {
          final keyMap = {
            "nickname": _nicknameController.text,
            // "imageUrl": _imageFile,
            "blogUrl": _blogController.text,
            "githubUrl": _githubIdController.text,
            "introduction": _introductionController.text,
          };

          setProfile(keyMap);
        }),
    );
  }
}
