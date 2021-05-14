import 'package:flutter/material.dart';
import 'package:guam_front/commons/back.dart';
import 'package:guam_front/screens/projects/project_search_form.dart';

class SearchScreen extends StatelessWidget {
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
                  Padding(padding: EdgeInsets.fromLTRB(10, 0, 0, 0)),
                  IconButton(
                      icon: Icon(
                        Icons.sort,
                        color: Colors.black,
                        size: 30,
                      ),
                      onPressed: () {

                      })
                ],
              )
          ),
          // _buildBody(context)
        ],
      ),
    ));
  }
}
