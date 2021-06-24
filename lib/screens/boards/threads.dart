import 'package:flutter/material.dart';
import 'package:guam_front/screens/boards/thread.dart';
import '../../commons/grey_container.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread.dart';
import 'iconTitle.dart';

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
                    DecoratedBox(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white,
                      ),
                      child: Container(
                        height: 36,
                        padding: EdgeInsets.symmetric(horizontal: 6),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextField(
                                decoration: null,
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.send_outlined),
                              onPressed: () {}, )
                          ],
                        ),
                      )
                    )
                  ],
                ),
              )
            )
          )
        ]
      )
    );
    /*
    return GreyContainer(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '스레드',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          Container(
            child: Column(
                children: [...threads.map((e) => Thread(e))],
            ),
          )
        ],
      ),
    );
     */
  }
}
