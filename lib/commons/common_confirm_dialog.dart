import 'package:flutter/material.dart';

class CommonConfirmDialog extends StatelessWidget {
  final String dialogText;
  final String confirmText;
  final String declineText;
  final Function onPressConfirm;
  final Function onPressDecline;

  CommonConfirmDialog({@required this.dialogText, this.confirmText = "확인",
    this.declineText = "취소", this.onPressConfirm, this.onPressDecline});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))
      ),
      titlePadding: EdgeInsets.all(0),
      title: Container(
          padding: EdgeInsets.all(10),
          child: Row(
              children: [
                Icon(Icons.notifications_none, size: 16),
                Text(" 알림", style: TextStyle(fontSize: 12))
              ]
          )
      ),
      contentPadding: EdgeInsets.all(10),
      content: Text(
          dialogText,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 14,
              color: Colors.black
          )
      ),
      actions: [
        TextButton(
          child: Text(
              "확인",
              style: TextStyle(
                fontSize: 14,
                color: Color.fromRGBO(85, 88, 255, 1),
              )
          ),
          onPressed: () {
            if (onPressConfirm != null) onPressConfirm();
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: Text(
              "취소",
              style: TextStyle(
                fontSize: 14,
                color: Colors.red,
              )
          ),
          onPressed: () {
            if (onPressDecline != null) onPressDecline();
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
