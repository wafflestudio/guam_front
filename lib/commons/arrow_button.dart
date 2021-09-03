import 'package:flutter/material.dart';

class ArrowButton extends StatelessWidget {
  final Function onTap;
  final bool active;
  final bool isRightArrow;

  ArrowButton({this.onTap, this.active, this.isRightArrow=true});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: active ? onTap : null,
        child: IconButton(
          padding: EdgeInsets.all(0),
          icon: Icon(
            this.isRightArrow ? Icons.arrow_right : Icons.arrow_left,
            color: active ? Colors.black : Colors.transparent,
          ),
          iconSize: 60,
        ),
      )
    );
  }
}
