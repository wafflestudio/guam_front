import 'package:flutter/material.dart';
import '../user_auth/sign_out.dart';

class MyPageBody extends StatelessWidget {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _nicknameController = TextEditingController();
  final TextEditingController _blogController = TextEditingController();
  final TextEditingController _githubIdController = TextEditingController();
  final TextEditingController _introductionController = TextEditingController();
  final TextEditingController _hashtagController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(color: Colors.grey),
          Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, left: 120, right: 120, bottom: 50),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://media.vlpt.us/images/nickanism/post/06e649c9-fc39-406a-9c54-375bd2ab0d62/lfVWBmiW_400x400.png"),
                    ),
                  ),
                ),
                ),
                Stack(
                  children: <Widget>[
                    _inputForm(size),
                    _authButton(size)
                  ],
                ),
                Center(child: SignOut()),
              ]
          ),
        ],
      ),
    );
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
            key: _formKey,
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

  Widget _authButton(Size size){
    return Positioned(
      left: size.width*0.15,
      right: size.width*0.15,
      bottom: 0,
      child: RaisedButton(
          child: Text("저장"),
          color: Colors.indigoAccent,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15)),
          onPressed: (){
          }),
    );
  }
}

