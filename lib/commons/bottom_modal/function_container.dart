import 'package:flutter/material.dart';

class FunctionContainer extends StatelessWidget {
  final Function customFunction;
  final IconData iconData;
  final String text;
  final String detailText;
  final Color iconColor;
  final Color textColor;
  final Color defaultColor = Colors.black;
  final bool requireConfirm;

  FunctionContainer({this.customFunction, this.iconData, this.text,this.detailText, this.iconColor, this.textColor, this.requireConfirm = false});

  @override
  Widget build(BuildContext context) {

    Future<void> _showMyDialog() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20))
            ),
            titlePadding: EdgeInsets.all(0),
            title: Container(
              padding: EdgeInsets.all(15),
              child: Row(
                  children: <Widget>[
                    Icon(Icons.notifications_none, size: 20),
                    Text(" 알림", style: TextStyle(fontSize: 17))
                  ]
              )
            ),
            contentPadding: EdgeInsets.all(20),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text(
                    "$detailText",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "확인",
                  style: TextStyle(
                    fontSize: 17, color: Color.fromRGBO(85, 88, 255, 1), fontWeight: FontWeight.bold)),
                onPressed: () {
                  customFunction();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  "취소",
                  style: TextStyle(
                    fontSize: 17, color: Colors.red, fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    return InkWell(
      onTap: requireConfirm ? _showMyDialog : customFunction,
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
