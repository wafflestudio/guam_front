import 'package:flutter/material.dart';


class SearchProject extends SearchDelegate {
  String selectedProjects;

  final List<String> listExample;
  SearchProject(this.listExample);

  @override
  List<Widget> buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        icon: Icon(Icons.sort),
        onPressed: () {

        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context);
        },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return Container(
      child: Center(
        child: Text(selectedProjects),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> suggestedProjects = [];
    query.isEmpty
        ?? suggestedProjects.addAll(
        listExample.where(
              (element) => element.contains(query),
        )
    );

    return ListView.builder(
      itemCount: suggestedProjects.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.history),
          title: Text(
            suggestedProjects[index],
          ),
          onTap: () {},
        );
      },
    );
  }
}