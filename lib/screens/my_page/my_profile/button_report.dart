import 'package:flutter/material.dart';
import '../../../commons/buttons/common_outlined_button.dart';
import 'dart:io' show Platform;
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'modal_report.dart';

class ButtonReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return commonOutlinedButton(
      text: "Ask Guam anything 🏝️",
      onPressed: () {
        if (Platform.isAndroid) {
          showMaterialModalBottomSheet(
              context: context,
              builder: (_) => ModalReport()
          );
        } else {
          showCupertinoModalBottomSheet(
              context: context,
              builder: (_) => ModalReport()

          );
        }
      }
    );
  }
}
