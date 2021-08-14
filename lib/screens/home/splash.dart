import 'package:flutter/material.dart';
import 'guam_text.dart';

class Splash extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<Offset> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 900),
      vsync: this,
    )..forward();

    _animation = Tween<Offset>(
      begin: Offset(1.0, 0.0),
      end: Offset(0.0, 0.0)
    ).animate(CurvedAnimation(
        parent: _animationController,
        curve: Interval(
          1/9,
          1,
          curve: Curves.linear,
        )
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            GuamText(),
            SlideTransition(
              position: _animation,
              child: Image(
                image: AssetImage("assets/backgrounds/splash-bg.png"),
              )
            )
          ],
        )
      ),
    );
  }
}
