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
              child: Text(""),
              // child: Text("$text", style: TextStyle(color: Colors.white),),
              decoration: BoxDecoration(
                color: Colors.yellow,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              ),
            ),
            contentPadding: EdgeInsets.all(20),
            content: SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  Text("$detailText"),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('확인', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
                onPressed: () {
                  customFunction();
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text('취소', style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
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
