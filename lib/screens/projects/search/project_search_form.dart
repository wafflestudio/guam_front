import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';

class SearchForm extends StatefulWidget {
  final Map<dynamic, dynamic> result;
  final Projects projectsProvider;

  SearchForm(this.result, this.projectsProvider);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();

  Map get results => widget.result;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 6,
      child: TextField(
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 20,
        ),
        autofocus: true,
        controller: _filter,
        onSubmitted: (e) {
          final searchInfo = {
            "keyword": _filter.text,
            "stacks": results['기술 스택'],
            "position": results['포지션'],
            "period": results['활동 기간'],
          };
          widget.projectsProvider.searchProjects(searchInfo);
        },
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            prefixIcon: Icon(
              Icons.search,
              color: Colors.black,
              size: 25,
            ),
            suffixIcon: focusNode.hasFocus
                ? IconButton(
                    icon: Icon(
                      Icons.cancel,
                      color: Colors.black,
                      size: 20,
                    ),
                    onPressed: () {
                      _filter.clear();
                      // _searchText = "";
                    })
                : Container(),
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
