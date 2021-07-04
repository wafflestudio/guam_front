import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../commons/profile_thumbnail.dart';
import '../../commons/app_bar.dart';
import '../../models/boards/thread.dart';
import '../../commons/circular_border_container.dart';
import 'package:hexcolor/hexcolor.dart';
import 'iconTitle.dart';
import '../../commons/thread_text_field.dart';
import 'comment.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';

class ThreadPage extends StatelessWidget {
  final Boards boardsProvider;
  final Thread thread;

  ThreadPage({this.boardsProvider, this.thread});

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
        //appBar: appBar(title: "스레드"),
        appBar: AppBar(
          title: Text("스레드"),
        ),
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
                          padding: EdgeInsets.only(bottom: 36),
                          child: FutureBuilder(
                            future: boardsProvider.fetchFullThread(thread.id),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                thread.fetchComments(snapshot.data);
                                return commentsContainer(thread);
                              } else {
                                return CircularProgressIndicator();
                              }
                            },
                          ),
                        ),
                      ]
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
      crossAxisAlignment: CrossAxisAlignment.start,
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
          title: "${thread.commentSize}개의 답글" // possible error !!
        ),
        Column(children: thread.comments.map((e) => Comment(e)).toList(),)
      ],
    ),
  );
}


