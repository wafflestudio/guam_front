import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'dart:io' show Platform;
import 'dart:ui';

const androidBottomNavigationHeight = 58;
const iosBottomNavigationHeight = 90;
const commonTextFieldHeight = 42;

double boardsBodyHeight(BuildContext context) {
  if (Platform.isAndroid) {
    return MediaQuery.of(context).size.height -
        CustomAppBar().preferredSize.height -
        MediaQueryData.fromWindow(window).padding.top -
        androidBottomNavigationHeight;
  } else {
    return MediaQuery.of(context).size.height -
        CustomAppBar().preferredSize.height -
        MediaQueryData.fromWindow(window).padding.top -
        iosBottomNavigationHeight + 2;  // 2 for slight mismatch in iOS safeArea height...
  }
}
