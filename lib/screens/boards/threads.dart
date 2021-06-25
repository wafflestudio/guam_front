import 'package:flutter/material.dart';
import 'package:guam_front/screens/boards/thread.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread.dart';
import 'iconTitle.dart';
import '../../commons/thread_text_field.dart';

class Threads extends StatelessWidget {
  final List<ThreadModel.Thread> threads;

  Threads(this.threads);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          iconTitle(icon: Icons.comment_outlined, title: "스레드"),
          SizedBox(
            width: double.infinity,
            height: 320, // temp
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(255, 255, 255, 0.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      height: 264, // temp: threads container 300 - textfield 36
                      child: ListView.builder(
                        itemBuilder: (context, idx) => Thread(threads[idx]),
                        itemCount: threads.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                      ),
                    ),
                    ThreadTextField(),
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
