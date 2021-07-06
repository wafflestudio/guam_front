import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../commons/profile_thumbnail.dart';
import '../../commons/app_bar.dart';
import '../../models/boards/thread.dart';
import '../../commons/circular_border_container.dart';
import 'package:hexcolor/hexcolor.dart';
import 'iconTitle.dart';
import '../../commons/common_text_field.dart';
import 'comment.dart';
import '../../providers/boards/boards.dart';
import '../../models/boards/comment.dart' as CommentModel;

class ThreadPage extends StatefulWidget {
  final Boards boardsProvider;
  final Thread thread;

  ThreadPage({this.boardsProvider, this.thread});

  @override
  State<StatefulWidget> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  Future<dynamic> comments;

  @override
  void initState() {
    comments = widget.boardsProvider.fetchFullThread(widget.thread.id);
    super.initState();
  }

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
                              threadContainer(widget.thread),
                              Padding(
                                padding: EdgeInsets.only(bottom: 36),
                                child: FutureBuilder<List<CommentModel.Comment>>(
                                  future: comments,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return commentsContainer(snapshot.data);
                                    } else {
                                      //print(snapshot.hasData);
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
                    //child: ThreadTextField(),
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

Widget commentsContainer(List<CommentModel.Comment> comments) {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
    child: Column(
      children: [
        iconTitle(
          icon: Icons.message_outlined,
          title: "${comments.length}개의 답글"
        ),
        Column(children: comments.map((e) => Comment(e)).toList(),)
      ],
    ),
  );
}


