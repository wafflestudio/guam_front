import 'package:flutter/material.dart';
import 'custom_button.dart';

class AcceptedDeclinedThreadButton extends StatelessWidget {
  final bool accepted;

  AcceptedDeclinedThreadButton({@required this.accepted});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: customButton(
          content: accepted ? "승인됨" : "반려됨",
          color: Colors.grey,
          onPressed: null,
        ),
      ),
    );
  }
}
