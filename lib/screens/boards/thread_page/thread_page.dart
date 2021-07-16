import 'package:flutter/material.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/back.dart';
import '../../../models/boards/thread.dart';
import '../../../commons/common_text_field.dart';
import '../../../providers/boards/boards.dart';
import '../../../models/boards/comment.dart' as CommentModel;
import 'thread_container.dart';
import 'comments_container.dart';

class ThreadPage extends StatefulWidget {
  final Boards boardsProvider;
  final Thread thread;

  ThreadPage({this.boardsProvider, this.thread});

  @override
  State<StatefulWidget> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  Future<dynamic> comments;

  void fetchFullThread() {
    setState(() {
      comments = widget.boardsProvider.fetchFullThread(widget.thread.id);
    });
  }

  @override
  void initState() {
    comments = widget.boardsProvider.fetchFullThread(widget.thread.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    Future postComment({Map<String, dynamic> fields, dynamic files}) async {

      return await widget.boardsProvider.postComment(
        threadId: widget.thread.id,
        fields: fields,
        files: files,
      ).then((successful) {
          if (successful) fetchFullThread();
          return successful;
        });
    }

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
          appBar: CustomAppBar(
            title: "스레드",
            leading: Back(),
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
                              ThreadContainer(thread: widget.thread),
                              Padding(
                                padding: EdgeInsets.only(bottom: 36),
                                child: FutureBuilder<List<CommentModel.Comment>>(
                                  future: comments,
                                  builder: (context, snapshot) {
                                    if (snapshot.hasData) {
                                      return CommentsContainer(comments: snapshot.data);
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
                    child: CommonTextField(onTap: postComment),
                  )
                ],
              )
          ),
        )
    );
  }
}


