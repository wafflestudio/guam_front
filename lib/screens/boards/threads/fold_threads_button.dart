import 'package:flutter/material.dart';

class FoldThreadsButton extends StatelessWidget {
  final String buttonText;
  final Function onPressed;

  FoldThreadsButton({@required this.buttonText, @required this.onPressed}) ;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 24),
      child: OutlinedButton(
        onPressed: () => onPressed(),
        child: Text(
          buttonText,
          style: TextStyle(
            fontSize: 14,
            color: Colors.black
          )
        ),
        style: OutlinedButton.styleFrom(
          backgroundColor: Color.fromRGBO(203, 203, 203, 0.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          padding: EdgeInsets.symmetric(horizontal: 15),
          side: BorderSide.none
        ),
      ),
    );
  }
}
