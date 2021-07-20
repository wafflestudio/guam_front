import 'package:flutter/material.dart';
import 'package:guam_front/screens/boards/thread.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread.dart';
import 'iconTitle.dart';
import '../../commons/common_text_field.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';

class Threads extends StatefulWidget {
  final List<ThreadModel.Thread> threads;

  Threads(this.threads);

  @override
  State<StatefulWidget> createState() => ThreadsState();
}

class ThreadsState extends State<Threads> {
  ThreadModel.Thread editTargetThread;

  void switchToEditMode({ThreadModel.Thread editTargetThread}) {
    setState(() {
      this.editTargetThread = editTargetThread;
    });
    Navigator.of(context).pop(); // pops Modal Bottom Content Widget
  }

  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.read<Boards>();

    Future postThread({Map<String, dynamic> fields, dynamic files}) async =>
        await boardsProvider.postThread(fields: fields, files: files);

    Future editThreadContent({int id, Map<String, dynamic> fields}) async {
      return await boardsProvider.editThreadContent(id: id, fields: fields)
          .then((successful) {
            if (successful) {
              setState(() {
                this.editTargetThread = null;
              });
              return successful;
            }
      });
    }

    return Padding(
        padding: EdgeInsets.only(bottom: 12),
        child: Column(
            children: [
              iconTitle(icon: Icons.comment_outlined, title: "스레드"),
              SizedBox(
                  width: double.infinity,
                  //height: 520, // temp
                  child: DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Color.fromRGBO(255, 255, 227, 1),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 464, // temp: threads container 500 - textfield 36
                              child: ListView.builder(
                                itemBuilder: (context, idx) => Thread(widget.threads[idx], switchToEditMode: switchToEditMode),
                                itemCount: widget.threads.length,
                                shrinkWrap: true,
                                physics: ClampingScrollPhysics(),
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
