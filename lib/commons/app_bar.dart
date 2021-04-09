import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:hexcolor/hexcolor.dart';

PreferredSizeWidget appBar({@required String title, dynamic leading, dynamic trailing}) {
  var themeColor = HexColor('#6200EE');
  var textColor = HexColor('#f0f0f9');
  var iconColor = HexColor('#f0f0f9');

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
      iconTheme: IconThemeData(
        color: textColor
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
      backgroundColor: themeColor,
    );
  }
}
