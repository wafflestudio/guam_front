import 'package:flutter/material.dart';

class ExitTutorialButton extends StatelessWidget {
  final Function onExit;

  ExitTutorialButton({@required this.onExit});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
          onTap: onExit,
          child: IconButton(
            padding: EdgeInsets.all(0),
            icon: Icon(
              Icons.check_circle_rounded,
              color: Colors.black,
              size: 30,
            ),
            iconSize: 60,
          ),
        )
    );
  }
}
