import 'package:flutter/material.dart';

Widget commonOutlinedButton({@required String text, @required Function onPressed}) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      child: Text(
        text,
        style: TextStyle(color: Colors.black),
      ),
      onPressed: () => onPressed(),
      style: ButtonStyle(
          // fixedSize: MaterialStateProperty.resolveWith((states) => Size.fromWidth(double.infinity)),
          backgroundColor: MaterialStateProperty.resolveWith((states) => Color.fromRGBO(233, 233, 233, 1))
      ),
    ),
  );
}
