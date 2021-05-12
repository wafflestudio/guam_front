import 'package:flutter/material.dart';
import '../../commons/grey_container.dart';
import '../../models/boards/thread.dart';

class Threads extends StatelessWidget {
  final List<Thread> threads;

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
        ],
      ),
    );
  }
}
