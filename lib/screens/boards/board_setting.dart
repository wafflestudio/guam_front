import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:guam_front/providers/stacks/stacks.dart';
import 'package:guam_front/screens/projects/creation/project_edit.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

import '../../commons/bottom_modal/bottom_modal_content.dart';
import '../../providers/boards/boards.dart';

class BoardSetting extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Boards boardsProvider = context.read<Boards>();
    final stacksProvider = context.read<Stacks>();

    return IconButton(
      icon: Icon(Icons.settings, color: Colors.black),
      onPressed: () {
        if (boardsProvider.currentBoard != null) {
          final String boardTitleEllipsis = boardsProvider.currentBoard.title.length > 15
            ? boardsProvider.currentBoard.title.replaceRange(15, null, "...")
            : boardsProvider.currentBoard.title;

          if (Platform.isAndroid) {
            showMaterialModalBottomSheet(
              context: context,
              builder: (_) => BottomModalContent(
                setIcon: Icons.flag_outlined,
                setText: "'$boardTitleEllipsis' 완료하기",
                setDetailText: "프로젝트를 완료시겠습니까?",
                editText: "'$boardTitleEllipsis' 수정하기",
                deleteText: boardsProvider.isMe(boardsProvider.currentBoard.leader.id)
                  ? "'$boardTitleEllipsis' 삭제하기"
                  : "'$boardTitleEllipsis' 나가기",
                deleteDetailText: boardsProvider.isMe(boardsProvider.currentBoard.leader.id)
                  ? "프로젝트를 삭제하시겠습니까?"
                  : "프로젝트를 나가시겠습니까?",
                setFunc: boardsProvider
                    .isMe(boardsProvider.currentBoard.leader.id)
                    ? () async {
                  await boardsProvider.completeBoard();
                  Navigator.of(context).pop();
                }
                    : null,
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
                },
                setRequireConfirm: true,
                deleteRequireConfirm: true,
              )
            );
          } else {
            showCupertinoModalBottomSheet(
              context: context,
              builder: (_) => BottomModalContent(
                setIcon: Icons.flag_outlined,
                setText: "'$boardTitleEllipsis' 완료하기",
                setDetailText: "프로젝트를 완료시겠습니까?",
                editText: "'$boardTitleEllipsis' 수정하기",
                deleteText: boardsProvider.isMe(boardsProvider.currentBoard.leader.id)
                  ? "'$boardTitleEllipsis' 삭제하기"
                  : "'$boardTitleEllipsis' 나가기",
                deleteDetailText: boardsProvider.isMe(boardsProvider.currentBoard.leader.id)
                  ? "프로젝트를 삭제하시겠습니까?"
                  : "프로젝트를 나가시겠습니까?",
                setFunc: boardsProvider
                    .isMe(boardsProvider.currentBoard.leader.id)
                    ? () async {
                  await boardsProvider.completeBoard();
                  Navigator.of(context).pop();
                }
                    : null,
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
                },
                setRequireConfirm: true,
                deleteRequireConfirm: true,
              )
            );
          }
        }
      }
    );
  }
}
