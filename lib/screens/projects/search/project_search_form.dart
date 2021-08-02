import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchForm extends StatefulWidget {
  final Map<dynamic, dynamic> result;
  final Projects projectsProvider;

  SearchForm(this.result, this.projectsProvider);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _searchController = TextEditingController();

  FocusNode focusNode = FocusNode();

  Map get results => widget.result;

  void setSearchInfo() {
    setState(() {
      results["keyword"] = _searchController.text;
    });
    widget.projectsProvider.searchProjects({
      "keyword": results['keyword'],
      "stacks": results['기술 스택'],
      "position": results['포지션'],
      "period": results['활동 기간'],
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
