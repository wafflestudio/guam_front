import 'package:flutter/material.dart';

class ThreadTextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
                  decoration: null,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send_outlined),
                onPressed: () {},
              )
            ],
          ),
        )
    );
  }
}
