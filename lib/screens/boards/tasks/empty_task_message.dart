import 'package:flutter/material.dart';
import '../../../commons/common_text_field.dart';

class EmptyTaskMessage extends StatelessWidget {
  final Function createTaskMsg;

  EmptyTaskMessage({@required this.createTaskMsg});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      width: double.infinity,
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: CommonTextField(
              onTap: createTaskMsg,
              allowImages: false,
            ),
          )
      ),
    );
  }
}
