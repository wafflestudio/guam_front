import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../commons/profile_thumbnail.dart';
import '../../commons/app_bar.dart';
import '../../models/boards/thread.dart';
import '../../commons/circular_border_container.dart';
import 'package:hexcolor/hexcolor.dart';

class ThreadPage extends StatelessWidget {
  final Thread thread;

  ThreadPage(this.thread);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.white,
        image: DecorationImage(
            image: AssetImage("assets/backgrounds/thread-page-bg.png"),
            fit: BoxFit.cover
        ),
      ),
      child: Scaffold(
        appBar: appBar(title: "스레드"),
        body: Container(
          height: double.infinity,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                children: [
                  threadContainer(thread)
                ],
              ),
            )
          ),
        ),
        backgroundColor: Colors.transparent,
      )
    );
  }
}

Widget threadContainer(Thread thread) {
  return CircularBorderContainer(
    content: Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: Row(
            children: [
              ProfileThumbnail(
                profile: thread.creator,
                showNickname: true,
                radius: 12,
              ),
              Padding(padding: EdgeInsets.only(right: 10)),
              Text(
                DateFormat("M월 d일 hh:mm").format(thread.createdAt).toString(),
                style: TextStyle(
                  fontSize: 10,
                  color: HexColor("#818181"),
                )
              )
            ],
          ),
        ),
        Text(thread.content)
      ],
    ),
    contentColor: Color.fromRGBO(246, 228, 173, 0.6),
  );
}


