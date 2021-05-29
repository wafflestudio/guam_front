import 'package:flutter/material.dart';

class NextPage extends StatelessWidget {
  final Widget nextPage;
  final String text;
  final double buttonWidth;
  final Map data;

  NextPage({this.nextPage, this.text, this.buttonWidth, this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => nextPage));
          },
          child: Container(
            alignment: Alignment.center,
            width: buttonWidth,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: Colors.white24,
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        ));
  }
}
