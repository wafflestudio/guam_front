import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import '../../../commons/custom_app_bar.dart';
import '../../../commons/common_text_field.dart';
import '../../../commons/common_sizes.dart';
import '../../../providers/boards/boards.dart';
import '../../../models/boards/thread.dart' as ThreadModel;
import '../iconTitle.dart';
import 'thread.dart';
import 'fold_threads_button.dart';

class Threads extends StatefulWidget {
  final List<ThreadModel.Thread> threads;

  Threads(this.threads);

  @override
  State<StatefulWidget> createState() => ThreadsState();
}

class ThreadsState extends State<Threads> {
  ThreadModel.Thread editTargetThread;
  bool foldThreads;
  final ScrollController _threadsController = ScrollController();

  @override
  void initState() {
    super.initState();
    foldThreads = true;
    WidgetsBinding.instance.addPostFrameCallback((_) => scrollThreadsToBottom());
  }

  @override
  void dispose() {
    _threadsController.dispose();
    super.dispose();
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

  void scrollThreadsToBottom() {
    if (widget.threads.isNotEmpty) {
      _threadsController.animateTo(
          _threadsController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeOut
      );
    }
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

    const double threadsPadding = 10;
    const double foldedThreadsHeight = 208;
    const double boardItemPadding = 10;
    const double iconTitleHeight = 36;
    double boardsBodyHeight;

    if (Platform.isAndroid) {
      boardsBodyHeight =
          MediaQuery.of(context).size.height -
          CustomAppBar().preferredSize.height -
          MediaQueryData.fromWindow(window).padding.top -
          androidBottomNavigationHeight;
    } else {
      boardsBodyHeight =
          MediaQuery.of(context).size.height -
          CustomAppBar().preferredSize.height -
          MediaQueryData.fromWindow(window).padding.top -
          iosBottomNavigationHeight + 2;  // 2 for slight mismatch in iOS safeArea height...
    }

    double threadsHeight = foldThreads
        ? foldedThreadsHeight
        : boardsBodyHeight - ( boardItemPadding * 2 + iconTitleHeight );

    double threadsContentsHeight = threadsHeight -
        ( threadsPadding * 2 + commonTextFieldHeight );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            iconTitle(icon: Icons.comment_outlined, title: "스레드"),
            FoldThreadsButton(
              buttonText: foldThreads ? "펼치기" : "접기",
              onPressed: toggleFoldThreads
            )
          ],
        ),
        SizedBox(
          width: double.infinity,
          height: threadsHeight,
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Color.fromRGBO(203, 203, 203, 0.5),
            ),
            child: Padding(
              padding: EdgeInsets.all(threadsPadding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: threadsContentsHeight // !important
                      ),
                      child: RefreshIndicator(
                        child: ListView.builder(
                          controller: _threadsController,
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
    );
  }
}
