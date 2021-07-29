import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NextPage extends StatelessWidget {
  final int page;
  final Function onTap;
  bool active;

  NextPage({@required this.page, @required this.onTap}) : this.active = true;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: InkWell(
            onTap: active ? onTap : null,
            child: Container(
              alignment: Alignment.center,
              width: page == 1
                  ? MediaQuery.of(context).size.width * 0.9
                  : MediaQuery.of(context).size.width * 0.45,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.white24,
                ),
                gradient: !active
                    ? null
                    : LinearGradient(
                    colors: [
                      HexColor("4F34F3"),
                      HexColor("3EF7FF"),
                    ],
                    begin: FractionalOffset(1.0, 0.0),
                    end: FractionalOffset(0.0, 0.0),
                    stops: [0, 1],
                    tileMode: TileMode.clamp),
                borderRadius: BorderRadius.circular(30),
              ),
              child: Text(
                '다음',
                style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            )));
  }
}

