import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../commons/profile_thumbnail.dart';
import '../../commons/custom_app_bar.dart';
import '../../models/boards/thread.dart';
import '../../commons/circular_border_container.dart';
import 'package:hexcolor/hexcolor.dart';
import 'iconTitle.dart';
import '../../commons/thread_text_field.dart';
import 'comment.dart';

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
        backgroundColor: Colors.transparent,
        appBar: CustomAppBar(title: "스레드"),
        body: Container(
          height: double.infinity,
          child: Stack(
            children: [
              SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                    child: Column(
                      children: [
                        threadContainer(thread),
                        Padding(
                          child: commentsContainer(thread),
                          padding: EdgeInsets.only(bottom: 36),
                        ),
                      ],
                    ),
                  )
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 20,
                  horizontal: 20
                ),
                alignment: Alignment.bottomCenter,
                child: ThreadTextField(),
              )
            ],
          )
        ),
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

Widget commentsContainer(Thread thread) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    child: Column(
      children: [
        iconTitle(
          icon: Icons.message_outlined,
          title: "${thread.comments.length}개의 답글"
        ),
        Column(children: thread.comments.map((e) => Comment(e)).toList(),)
      ],
    ),
  );
}


