import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class CircularBorderContainer extends StatelessWidget {
  final Widget header;
  final Widget content;
  final Color headerColor;
  final Color contentColor;

  CircularBorderContainer({this.header, this.content, this.headerColor, this.contentColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: DecoratedBox(
        child: Column(
          children: [
            if (header != null)
              Container(
                width: double.infinity,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadiusDirectional.vertical(top: Radius.circular(5)),
                    color: headerColor?? Color.fromRGBO(155, 155, 155, 0.3),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: 6, horizontal: 10
                    ),
                    child: header,
                  )
                )
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12, horizontal: 10),
              child: content,
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: contentColor ?? HexColor('#EBEBEB'),
          borderRadius: BorderRadius.circular(5),
        ),
      ),
    );
  }
}
