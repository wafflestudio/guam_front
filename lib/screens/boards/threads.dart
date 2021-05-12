import 'package:flutter/material.dart';
import 'package:guam_front/screens/boards/thread.dart';
import '../../commons/grey_container.dart';
import '../../models/boards/thread.dart' as ThreadModel;
import 'thread.dart';

class Threads extends StatelessWidget {
  final List<ThreadModel.Thread> threads;

  Threads(this.threads);

  @override
  Widget build(BuildContext context) {
    return GreyContainer(
      height: 420,
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
  }
}
