import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          children: [
            Text(
              "G",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                fontSize: 80,
              ),
            ),
            Text(
              "uam",
              style: TextStyle(
                fontFamily: "Poppins",
                fontWeight: FontWeight.w700,
                fontSize: 55,
              ),
            ),
          ],
        )
      ),
    );
  }
}
