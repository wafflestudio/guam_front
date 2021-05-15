import 'package:flutter/material.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/screens/projects/project_seach_filter.dart';
import 'package:guam_front/screens/projects/project_search_form.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isFilterOpen;

  @override
  void initState() {
    // TODO: implement initState
    isFilterOpen = false;
    super.initState();
  }

  void _isFilterOpenChange() {
    setState(() {
      isFilterOpen = !isFilterOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /* customizing하신 appBar의 경우, text 자리에 string만 가능한
       상태라서 임시방편으로 AppBar 사용했습니다. */
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: Back(),
        title: Column(
          children: <Widget>[
            Container(
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    SearchForm(),
                    RotatedBox(
                      quarterTurns: isFilterOpen ? 1 : 0,
                      child: IconButton(
                        icon: Icon(
                          Icons.sort,
                          color: Colors.black,
                        ),
                        onPressed: _isFilterOpenChange,
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Container(color: Colors.white70),
            Container(
              child: isFilterOpen ? SearchFilter() : Container(),
            ),
            Column(
              children: <Widget>[
                SizedBox(width: 20, height: 200),
                Container(color: Colors.black),
                Text(
                  "검색 결과",
                  style: TextStyle(color: Colors.black),
                ),

                /* 검색 결과 Body */
                // _buildBody(context)
                //
              ],
            ),
          ],
        ),
      ),
    );
  }
}
