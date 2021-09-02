import 'package:flutter/material.dart';

class BoardsPlaceHolder extends StatelessWidget {
  final String placeholderText = "현재 참여중인 작업실이 없습니다.\n프로젝트를 만들거나 참여하세요!";

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;

    return Center(
      child: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(
              image: AssetImage("assets/images/boards_placeholder.png"),
              fit: BoxFit.cover,
            ),
            Padding(padding: EdgeInsets.only(bottom: 19)),
            FittedBox(  // ensures each text line is fitted in a single line.
              child: Text(
                placeholderText,
                style: TextStyle(
                  color: Color.fromRGBO(124, 124, 124, 1),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                  letterSpacing: 0.15
                ),
              ),
            )
          ],
        ),
      )
    );
  }
}
