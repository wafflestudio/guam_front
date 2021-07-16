import 'package:flutter/material.dart';

class FunctionContainer extends StatelessWidget {
  final Function customFunction;
  final IconData iconData;
  final String text;
  final Color iconColor;
  final Color textColor;
  final Color defaultColor = Colors.black;

  FunctionContainer({this.customFunction, this.iconData, this.text, this.iconColor, this.textColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: customFunction,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 13),
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white
              ),
              child: Icon(iconData, color: iconColor ?? defaultColor),
            ),
            Text(
              text,
              style: TextStyle(
                  fontSize: 14,
                  color: textColor ?? defaultColor
              ),
            )
          ],
        ),
      ),
    );
  }
}
