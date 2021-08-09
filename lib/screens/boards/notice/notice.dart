import 'package:flutter/material.dart';
import 'package:guam_front/screens/my_page/another_profile/another_profile_app.dart';
import 'package:provider/provider.dart';

import '../../../commons/circular_border_container.dart';
import '../../../commons/profile_thumbnail.dart';
import '../../../models/boards/thread.dart' as ThreadModel;
import '../../../providers/boards/boards.dart';

class Notice extends StatelessWidget {
  final ThreadModel.Thread notice;

  Notice(this.notice);

  @override
  Widget build(BuildContext context) {
    final boardsProvider = context.read<Boards>();

    return notice != null
        ? Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: CircularBorderContainer(
              header: Row(
                children: [
                  Icon(Icons.push_pin_outlined),
                  Padding(padding: EdgeInsets.only(right: 8)),
                  Text(
                    '고정',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              headerColor: boardsProvider
                  .renderBoardColor[boardsProvider.renderBoardIdx],
              content: Container(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProfileThumbnail(
                      profile: notice.creator,
                      radius: 12,
                      showNickname: false,
                      activateRedirectOnTap: true,
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  AnotherProfile(notice.creator.id))),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 9),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              notice.content ?? "",
                              style: TextStyle(fontSize: 12),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ))
        : Container();
  }
}
