import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

class NextPage extends StatefulWidget {
  final int page;
  final Function onTap;
  final List<bool> active;

  NextPage({@required this.page, @required this.onTap, @required this.active});

  @override
  _NextPageState createState() => _NextPageState();
}

class _NextPageState extends State<NextPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(5, 60, 5, 20),
        child: InkWell(
            onTap: widget.active.contains(false) ? null : widget.onTap,
            child: Container(
              alignment: Alignment.center,
              width: widget.page == 1
                  ? MediaQuery.of(context).size.width * 0.9
                  : MediaQuery.of(context).size.width * 0.45,
              height: 60,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1.5,
                  color: Colors.white24,
                ),
                gradient: widget.active.contains(false)
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
