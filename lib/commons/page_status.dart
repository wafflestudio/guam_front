import 'package:flutter/material.dart';

class ProjectStatus extends StatelessWidget {
  final int totalPage;
  final int currentPage;

  ProjectStatus({
    this.totalPage,
    this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    var pageList = Iterable<int>.generate(totalPage).toList();
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pageList.length, (idx) {
        return Container(
          margin: EdgeInsets.all(8),
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: (idx + 1) == currentPage ? Colors.white : Colors.white24,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}
