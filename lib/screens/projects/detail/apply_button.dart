import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../commons/button_size_circular_progress_indicator.dart';

Widget applyButton({double width, bool enabled, bool applying, Function applyProject}) {
  return Container(
    width: width,
    child: ElevatedButton(
        child: !applying
            ? Text(
              '참여하기',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold
              ))
            : ButtonSizeCircularProgressIndicator(),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith(
            (states) {
              if (states.contains(MaterialState.disabled)) return Colors.grey;
              else return HexColor("08951C");
            }
          ),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))
            ),
        ),
        onPressed: enabled && !applying ? () => applyProject() : null
    )
  );
}
