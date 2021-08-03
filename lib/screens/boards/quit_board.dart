import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import '../../commons/bottom_modal/bottom_modal_content.dart';
import 'dart:io' show Platform;
import 'package:provider/provider.dart';
import '../../providers/boards/boards.dart';

class QuitBoard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.read<Boards>();

    return IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.black,
        ),
        onPressed: () {
          if (boardsProvider.currentBoard != null) {
            if (Platform.isAndroid) {
              showMaterialModalBottomSheet(
                  context: context,
                  builder: (_) => BottomModalContent(
                      deleteText: "'${boardsProvider.currentBoard.title}' 나가기",
                      deleteFunc: () {}
                  )
              );
            } else {
              showCupertinoModalBottomSheet(
                  context: context,
                  builder: (_) => BottomModalContent(
                      deleteText: "'${boardsProvider.currentBoard.title}' 나가기",
                      deleteFunc: () {}
                  )
              );
            }
          }
        }
    );
  }
}
