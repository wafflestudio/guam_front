import 'package:flutter/material.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/search/project_search_form.dart';
import 'package:guam_front/screens/projects/search/projects_searched_list.dart';
import 'package:guam_front/screens/projects/search/search_filter_chip.dart';
import 'package:hexcolor/hexcolor.dart';
import 'filter_value_chip.dart';

class SearchScreen extends StatefulWidget {
  final Stacks stacksProvider;

  SearchScreen({this.stacksProvider});

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isFilterOpen;
  bool isSubmitted;
  Map result = {};
  String selectedKey;
  List<String> filterValues;
  FocusNode focusNode = FocusNode();

  @override
  void initState() {
    isFilterOpen = false;
    isSubmitted = false;
    super.initState();
  }

  void _toggleIsFilterOpen() {
    setState(() => isFilterOpen = !isFilterOpen);
  }

  void toggleIsSubmitted() {
    setState(() => isSubmitted = !isSubmitted);
  }

  void selectKey(String key, List<String> value) {
    setState(() {
      selectedKey = selectedKey == key ? null : key;
      filterValues = value;
    });
  }

  void selectValue(String value) {
    setState(() => result[selectedKey] = value);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Back(),
        title: Column(
          children: <Widget>[
            Container(
              height: 36,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  SearchForm(result),
                  IconButton(
                    icon: Icon(Icons.filter_list, color: Colors.black),
                    onPressed: _toggleIsFilterOpen,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  colorFilter: ColorFilter.mode(
                      Colors.white.withOpacity(0.6), BlendMode.dstATop),
                  image: AssetImage("assets/backgrounds/projects-bg-2.png"),
                  fit: BoxFit.cover,
                )
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  if (isFilterOpen) searchFilter(widget.stacksProvider, size),
                  Container(color: Colors.black),
                  ProjectsSearchedList()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget searchFilter(Stacks stacksProvider, Size size) {
    final Map filterOptions = {
      '기술 스택': List<String>.from(
          widget.stacksProvider.stacks.map((stack) => stack.name)),
      '포지션': ['백엔드', '프론트엔드', '디자이너'],
      '활동 기간': ['1개월 미만', '3개월 미만', '6개월 미만', '6개월 이상']
    };

    return Container(
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: HexColor("979797"),
        ),
      ),
      padding: EdgeInsets.only(top: 10.0, bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                ...filterOptions.entries.map((e) => SearchFilterChip(
                    content: e.key,
                    display: result[e.key] != null
                        ? "${e.key}: ${result[e.key]}"
                        : e.key,
                    selected: selectedKey == e.key,
                    selectKey: selectKey,
                    filterValues: e.value
                ))
              ],
            ),
          ),
          if (selectedKey != null)
            SizedBox(
              height: 40,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, idx) => FilterValueChip(
                  content: filterValues[idx],
                  selected: result[selectedKey] == filterValues[idx],
                  selectValue: selectValue,
                ),
                itemCount: filterValues.length,
              ),
            ),
        ],
      ),
    );
  }
}
