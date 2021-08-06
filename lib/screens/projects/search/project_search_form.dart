import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';

class SearchForm extends StatefulWidget {
  final Map<dynamic, dynamic> result;
  final Stacks stacksProvider;

  SearchForm(this.result, this.stacksProvider);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  Map get results => widget.result;

  setPosition(String positionKor) {
    String positionEng;
    switch (positionKor) {
      case '백엔드':
        positionEng = 'BACKEND';
        break;
      case '프론트엔드':
        positionEng = 'FRONTEND';
        break;
      case '디자이너':
        positionEng = 'DESIGNER';
        break;
    }
    return positionEng;
  }

  setPeriod(String periodStr) {
    String periodInt;
    switch (periodStr) {
      case '1개월 미만':
        periodInt = 'ONE';
        break;
      case '3개월 미만':
        periodInt = 'THREE';
        break;
      case '6개월 미만':
        periodInt = 'SIX';
        break;
      case '6개월 이상':
        periodInt = 'MORE';
        break;
    }
    return periodInt;
  }

  setTechStack(String stackStr) {
    if (stackStr != null) {
      return List<int>.from(
          widget.stacksProvider.stacks.map((stack) => stack.id))[
      List<String>.from(
          widget.stacksProvider.stacks.map((stack) => stack.name))
          .indexOf(results['기술 스택'])].toString();
    } else {
      return null;
    }
  }

  Future setSearchInfo() async {
    setState(() {
      results["keyword"] = _searchController.text;
    });
    await context.read<Projects>().searchProjects({
      "keyword": results['keyword'],
      "stackId": setTechStack(results['기술 스택']),
      "position": setPosition(results['포지션']),
      "due": setPeriod(results['활동 기간']),
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 17,
        ),
        autofocus: true,
        controller: _searchController,
        onSubmitted: (e) {
          setSearchInfo();
        },
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(left: 10),
            filled: true,
            fillColor: HexColor("#EFEFF0"),
            suffixIcon: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black,
                  size: 20,
                ),
                onPressed: () {
                  setSearchInfo();
                }),
            hintText: '검색',
            labelStyle: TextStyle(color: Colors.black45),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.all(Radius.circular(10)))),
      ),
    );
  }
}
