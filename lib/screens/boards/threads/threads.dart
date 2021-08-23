import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../commons/common_text_field.dart';
import '../../../providers/boards/boards.dart';
import '../../../models/boards/thread.dart' as ThreadModel;
import 'thread.dart';
import '../iconTitle.dart';

class Threads extends StatefulWidget {
  final List<ThreadModel.Thread> threads;

  Threads(this.threads);

  @override
  State<StatefulWidget> createState() => ThreadsState();
}

class ThreadsState extends State<Threads> {
  ThreadModel.Thread editTargetThread;
  bool foldThreads;

  @override
  void initState() {
    super.initState();
    foldThreads = true;
  }

  void switchToEditMode({@required ThreadModel.Thread editTargetThread}) {
    setState(() {
      this.editTargetThread = editTargetThread;
    });
  }

  void toggleFoldThreads() {
    setState(() {
      this.foldThreads = !this.foldThreads;
    });
  }

  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.read<Boards>();

    Future postThread({Map<String, dynamic> fields, dynamic files}) async =>
        await boardsProvider.postThread(fields: fields, files: files);

    Future editThreadContent({int id, Map<String, dynamic> fields}) async =>
       await boardsProvider.editThreadContent(threadId: id, fields: fields)
          .then((successful) {
            if (successful) {
              setState(() {
                this.editTargetThread = null;
              });
              return successful;
            }
      });

    double threadsHeight = foldThreads ? 208 : 480;

    return Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  iconTitle(icon: Icons.comment_outlined, title: "스레드"),
                  ConstrainedBox(
                    constraints: BoxConstraints(maxHeight: 24),
                    child: OutlinedButton(
                      onPressed: () => toggleFoldThreads(),
                      child: Text(
                        foldThreads ? "펼치기" : "접기",
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black
                        )
                      ),
                      style: OutlinedButton.styleFrom(
                        backgroundColor: Color.fromRGBO(203, 203, 203, 0.5),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        side: BorderSide.none
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                  width: double.infinity,
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(203, 203, 203, 0.5),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: threadsHeight,
                              child: RefreshIndicator(
                                child: ListView.builder(
                                  itemBuilder: (context, idx) => Thread(
                                      widget.threads[idx],
                                      switchToEditMode: switchToEditMode,
                                      isEditTarget: editTargetThread == widget.threads[idx]
                                  ),
                                  itemCount: widget.threads.length,
                                  shrinkWrap: true,
                                  physics: ClampingScrollPhysics(),
                                ),
                                onRefresh: () async {
                                  await boardsProvider.fetchThreads(queryParams: {
                                    "size": "${widget.threads.length + boardsProvider.defaultThreadsSize}"
                                  });
                                },
                              ),
                            ),
                            CommonTextField(
                              onTap: editTargetThread == null ? postThread : editThreadContent,
                              editTarget: editTargetThread ?? null,
                            ),
                          ],
                        ),
                      )
                  )
              )
            ]
        )
    );
  }
}
