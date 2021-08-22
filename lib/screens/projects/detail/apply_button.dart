import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget applyButton({double width, bool enabled, Function applyProject}) {
  return Container(
    width: width,
    child: ElevatedButton(
        child: Text(
          '참여하기',
          style: TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold)
          ,
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(
              enabled ? HexColor("08951C") : Colors.grey
            ),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
            ),
        ),
        onPressed: enabled ? () => applyProject() : null
    )
  );
}
