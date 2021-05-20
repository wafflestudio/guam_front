import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:guam_front/main.dart';
import 'package:hexcolor/hexcolor.dart';

PreferredSizeWidget appBar({@required String title, dynamic leading, dynamic trailing}) {
  var textColor = Colors.black;
  var iconColor = Colors.black;

  if (Platform.isAndroid) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      leading: leading,
      actions: trailing == null ? [] : [trailing],
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(
        color: iconColor,
      ),
    );
  } else {
    return CupertinoNavigationBar(
      middle: Text(
        title,
        style: TextStyle(
          color: textColor,
        ),
      ),
      leading: leading,
      trailing: trailing,
      backgroundColor: Colors.transparent,
    );
  }
}
