import 'package:flutter/material.dart';

class WaitingButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Align(
        alignment: Alignment.bottomRight,
        child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: 28),
            child: ElevatedButton(
              onPressed: null,
              style: ElevatedButton.styleFrom(
                primary: Colors.grey,
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                child: Text(
                  "대기중",
                  style: TextStyle(color: Colors.white),
                ),
              )
            )
        ),
      ),
    );
  }
}
