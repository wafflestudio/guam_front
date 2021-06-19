import 'package:flutter/material.dart';

Widget iconTitle({IconData icon, String title}) => Padding(
  child: Row(
    children: [
      Icon(icon),
      Padding(padding: EdgeInsets.only(right: 8)),
      Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      )
    ],
  ),
  padding: EdgeInsets.only(bottom: 12),
);
