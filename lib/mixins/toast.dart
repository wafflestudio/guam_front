import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';

mixin Toast on ChangeNotifier {
  void showToast ({@required bool success, @required String msg}) {
    BotToast.showText(
      text: msg,
      contentColor: success
          ? Colors.white
          : Color.fromRGBO(235, 87, 87, 1),
      borderRadius: BorderRadius.circular(30),
      textStyle: TextStyle(
        fontSize: 14,
        color: success ? Colors.black : Colors.white
      )
    );
  }
}
