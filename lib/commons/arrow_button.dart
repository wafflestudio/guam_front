import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final Function onTap;
  final bool active;
  final bool isRightArrow;

  ArrowButton({this.onTap, this.active, this.isRightArrow=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
      child: InkWell(
        onTap: active ? onTap : null,
        child: IconButton(
          icon: Icon(this.isRightArrow ? Icons.arrow_right : Icons.arrow_left),
          color: Colors.black,
          iconSize: 60,
        ),
      )
    );
  }
}