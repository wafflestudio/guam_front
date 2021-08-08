import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

mixin Toast on ChangeNotifier {
  void showToast ({@required bool success, @required String msg}) {
    Fluttertoast.showToast(
        msg: msg,
        textColor: Colors.red
        // backgroundColor: success
        //     ? Color.fromRGBO(85, 88, 255, 1)
        //     : Color.fromRGBO(235, 87, 87, 1)
    );
  }
}
