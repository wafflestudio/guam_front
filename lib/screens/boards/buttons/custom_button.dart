import 'package:flutter/material.dart';

Widget customButton({String content, Color color, Function onPressed}) {
  return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 28),
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              primary: color,
              padding: EdgeInsets.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
            child: Text(
              content,
              style: TextStyle(color: Colors.white),
            ),
          )
      )
  );
}
