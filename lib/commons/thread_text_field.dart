import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/boards/boards.dart';

class ThreadTextField extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ThreadTextFieldState();
}

class _ThreadTextFieldState extends State<ThreadTextField> {
  final _threadTextFieldController = TextEditingController();

  @override
  void dispose() {
    _threadTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.read<Boards>();

    return DecoratedBox(
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
                  controller: _threadTextFieldController,
                  decoration: null,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send_outlined),
                onPressed: () {
                  boardsProvider.postThread({
                    "value": _threadTextFieldController.text
                  });
                },
              )
            ],
          ),
        )
    );
  }
}
