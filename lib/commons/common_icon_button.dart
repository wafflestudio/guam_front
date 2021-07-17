import 'package:flutter/material.dart';

class CommonIconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;

  CommonIconButton({@required this.icon, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      padding: EdgeInsets.zero,
      constraints: BoxConstraints(
          maxWidth: 24, maxHeight: 24
      ),
      onPressed: onPressed
    );
  }
}
