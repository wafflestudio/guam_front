import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/creation/project_edit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../commons/bottom_modal/bottom_modal_content.dart';
import '../../providers/boards/boards.dart';
import '../../providers/projects/projects.dart';

class BoardSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.read<Boards>();
    final stacksProvider = context.read<Stacks>();

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
                  editText: "'${boardsProvider.currentBoard.title}' 수정하기",
                  deleteText: "'${boardsProvider.currentBoard.title}' 나가기",
                  editFunc: boardsProvider
                      .isMe(boardsProvider.currentBoard.leader.id)
                      ? () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider.value(
                              value: boardsProvider,
                              child: ProjectEdit(
                                stacksProvider: stacksProvider,
                                projectInfo: boardsProvider.currentBoard,
                              ),
                            )
                          )
                        );
                      }
                      : null,
                  deleteFunc: () async {
                    if (boardsProvider
                        .isMe(boardsProvider.currentBoard.leader.id)) {
                      await boardsProvider.deleteBoard();
                    } else {
                      await boardsProvider.quitBoard();
                    }
                    Navigator.of(context).pop();
                  })
              );
            } else {
              showCupertinoModalBottomSheet(
                context: context,
                builder: (_) => BottomModalContent(
                  editText: "'${boardsProvider.currentBoard.title}' 수정하기",
                  deleteText: "'${boardsProvider.currentBoard.title}' 나가기",
                    editFunc: boardsProvider
                        .isMe(boardsProvider.currentBoard.leader.id)
                        ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChangeNotifierProvider.value(
                                value: boardsProvider,
                                child: ProjectEdit(
                                  stacksProvider: stacksProvider,
                                  projectInfo: boardsProvider.currentBoard,
                                ),
                              )
                            )
                          );
                        }
                        : null,
                  deleteFunc: () async {
                    if (boardsProvider
                        .isMe(boardsProvider.currentBoard.leader.id)) {
                      await boardsProvider.deleteBoard();
                    } else {
                      await boardsProvider.quitBoard();
                    }
                    Navigator.of(context).pop();
                  })
              );
            }
          }
        });
  }
}
