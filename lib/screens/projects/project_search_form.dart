import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:guam_front/models/project.dart';
import 'package:guam_front/screens/projects/project_detail.dart';

class SearchForm extends StatefulWidget {
  @override
  _SearchFormState createState() => _SearchFormState();
}

class _SearchFormState extends State<SearchForm> {
  final TextEditingController _filter = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _searchText = "";

  _SearchFormState() {
    _filter.addListener(() {
      setState(() {
        _searchText = _filter.text;
      });
    });
  }

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
                      _searchText = "";
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


  // Widget _buildBody(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: /* Projects 검색 결과 */ ,
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return LinearProgressIndicator();
  //       return _buildList(context, snapshot.data.documents);
  //     },
  //   );
  // }
  //
  // Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  //   List<DocumentSnapshot> searchResults = [];
  //   for (DocumentSnapshot d in snapshot) {
  //     if (d.data.toString().contains(_searchText)) {
  //       searchResults.add(d);
  //     }
  //   }
  //
  //   return Expanded(
  //     child: GridView.count(
  //         crossAxisCount: 1,
  //         childAspectRatio: 2 / 3,
  //         padding: EdgeInsets.all(3),
  //         children: searchResults
  //             .map((data) => _buildListItem(context, data))
  //             .toList()),
  //   );
  // }
  //
  // Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  //   return InkWell(
  //       // child: Image.network(),
  //       onTap: () {
  //     Navigator.push(context,
  //         MaterialPageRoute(builder: (context) => DetailProject(project)));
  //   });
  // }
}
