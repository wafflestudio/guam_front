import 'package:flutter/material.dart';
import 'package:guam_front/screens/boards/thread.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread.dart';
import 'iconTitle.dart';
import '../../commons/common_text_field.dart';
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';

class Threads extends StatelessWidget {
  final List<ThreadModel.Thread> threads;

  Threads(this.threads);

  @override
  Widget build(BuildContext context) {

    Future postThread(dynamic body) async => await context.read<Boards>().postThread(body);

    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          iconTitle(icon: Icons.comment_outlined, title: "스레드"),
          SizedBox(
            width: double.infinity,
            height: 520, // temp
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
                        itemBuilder: (context, idx) => Thread(threads[idx]),
                        itemCount: threads.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                      ),
                    ),
                    CommonTextField(onTap: postThread),
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
