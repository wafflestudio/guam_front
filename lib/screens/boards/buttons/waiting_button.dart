import 'package:flutter/material.dart';
import 'custom_button.dart';

class WaitingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return customButton(
      content: "대기중",
      color: Colors.grey,
      onPressed: null,
    );
  }
}
