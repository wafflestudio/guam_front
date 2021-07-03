import 'package:flutter/material.dart';
import 'package:guam_front/providers/projects/projects.dart';
import 'package:hexcolor/hexcolor.dart';

class SearchForm extends StatefulWidget {
  final Map<dynamic, dynamic> result;
  final Projects projectsProvider;
  final Function toggleIsSubmitted;

  SearchForm(this.result, this.projectsProvider, this.toggleIsSubmitted);

  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _filter = TextEditingController();

  FocusNode focusNode = FocusNode();

  Map get results => widget.result;

  @override
  Widget build(BuildContext context) {
    final searchInfo = {
      "keyword": _filter.text,
      "stacks": results['기술 스택'],
      "position": results['포지션'],
      "period": results['활동 기간'],
    };

    return Expanded(
      child: TextField(
        focusNode: focusNode,
        style: TextStyle(
          fontSize: 17,
        ),
        autofocus: true,
        controller: _filter,
        onSubmitted: (e) {
          widget.projectsProvider.searchProjects(searchInfo);
          widget.toggleIsSubmitted();
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
                  widget.projectsProvider.searchProjects(searchInfo);
                  widget.toggleIsSubmitted();
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
