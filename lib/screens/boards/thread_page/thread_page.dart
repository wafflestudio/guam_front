import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../commons/custom_app_bar.dart';
import '../../../commons/back.dart';
import '../../../models/boards/thread.dart';
import '../../../commons/common_text_field.dart';
import '../../../providers/boards/boards.dart';
import '../../../models/boards/comment.dart' as CommentModel;
import 'thread_container.dart';
import 'comments_container.dart';

class ThreadPage extends StatefulWidget {
  final Thread thread;
  final Future<List<CommentModel.Comment>> comments;

  ThreadPage({this.thread, this.comments});

  @override
  State<StatefulWidget> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  Future<List<CommentModel.Comment>> comments;
  CommentModel.Comment editTargetComment;

  void switchToEditMode({@required CommentModel.Comment editTargetComment}) {
    setState(() {
      this.editTargetComment = editTargetComment;
    });
  }

  @override
  void initState() {
    comments = widget.comments;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.watch<Boards>();

    void fetchFullThread() {
      setState(() {
        comments = boardsProvider.fetchFullThread(widget.thread.id);
      });
    }

    Future postComment({Map<String, dynamic> fields, dynamic files}) async {
      return await boardsProvider.postComment(
        threadId: widget.thread.id,
        fields: fields,
        files: files,
      ).then((successful) {
          if (successful) fetchFullThread();
          return successful;
        });
    }

    Future editCommentContent({int id, Map<String, dynamic> fields}) async =>
        await boardsProvider.editCommentContent(
          commentId: id,
          fields: fields
        ).then((successful) {
          if (successful) {
            setState(() {
              this.editTargetComment = null;
            });
            fetchFullThread();
            return successful;
          }
        });

    Future deleteComment(int commentId) async {
      return await boardsProvider.deleteComment(commentId)
        .then((successful) async {
          if (successful) {
            bool isDeletedThread = widget.thread.content == null;
            bool wasLastComment = (await comments).length == 1;

            // Corner case: Deleting last comment on deleted thread.
            if (isDeletedThread && wasLastComment) Navigator.of(context).pop();
            else fetchFullThread();
          }
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
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                      child: Container(
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
                                    return CommentsContainer(
                                      comments: snapshot.data,
                                      switchToEditMode: switchToEditMode,
                                      deleteComment: deleteComment,
                                      editTargetComment: editTargetComment,
                                      fetchFullThread: fetchFullThread,
                                    );
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
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: CommonTextField(
                    onTap: editTargetComment == null ? postComment : editCommentContent,
                    editTarget: editTargetComment ?? null,
                  ),
                )
              ]
            ),
          ),
        )
    );
  }
}


