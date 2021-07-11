import 'package:flutter/material.dart';

class MyProfileLink extends StatelessWidget {
  const MyProfileLink({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 6, right: 8),
      child: Row(
        children: [
          Expanded(child: Container()),
          DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 4, horizontal: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.all(2),
                          icon: Image.asset('assets/images/browser-icon.png')),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: SizedBox(
                        height: 24,
                        width: 24,
                        child: IconButton(
                            onPressed: () {},
                            padding: EdgeInsets.all(2),
                            icon:
                                Image.asset('assets/images/github-icon.png'))),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: IconButton(
                          onPressed: () {},
                          padding: EdgeInsets.only(bottom: 2),
                          iconSize: 20,
                          icon: Icon(Icons.ios_share)),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
