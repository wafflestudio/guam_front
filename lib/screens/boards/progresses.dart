import 'package:flutter/material.dart';
import 'package:guam_front/commons/profile_thumbnail.dart';
import '../../models/boards/user_progress.dart';
import 'iconTitle.dart';

class Progresses extends StatefulWidget {
  final List<UserProgress> progresses;

  Progresses(this.progresses);

  @override
  State<StatefulWidget> createState() => ProgressesState();
}

class ProgressesState extends State<Progresses> {
  int selectedUserId; // 일단 임시로 첫 번째 사람으로 set. 최종으론 내 아이디로 init. 내 작업현황이 가장 먼저 뜨게 할 것임.
  List<UserProgress> unselectedUsers;

  @override
  void initState() {
    super.initState();
    selectedUserId = widget.progresses.first.user.id;
    unselectedUsers = widget.progresses.where((e) => e.user.id != selectedUserId).toList();
  }

  void selectUser(int userId) {
    setState(() {
      selectedUserId = userId;
      unselectedUsers = widget.progresses.where((e) => e.user.id != selectedUserId).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          iconTitle(icon: Icons.file_present, title: "작업 현황"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(85, 88, 255, 0.8),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ProfileThumbnail(
                                profile: widget.progresses.firstWhere((e) => e.user.id == selectedUserId).user,
                                radius: 12,
                                showNickname: true,
                                textColor: Colors.white,
                              ),
                              positionChip(),
                            ],
                          ),
                        )
                    )
                  // media query to the box aside
                ),
                Padding(padding: EdgeInsets.only(left: 5)),
                DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(155, 155, 155, 0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 6),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [...unselectedUsers.map((e) =>
                              InkWell(
                                onTap: () => selectUser(e.user.id),
                                child: Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 5),
                                  child: ProfileThumbnail(
                                    profile: e.user,
                                    radius: 10,
                                    showNickname: false,
                                  ),
                                ),
                              )
                          )]
                      ),
                    )
                ),
              ],
            ),
          ),
          Padding(padding: EdgeInsets.only(bottom: 10)),
          SizedBox(
            width: double.infinity,
            height: 132, // temp,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(123, 116, 232, 0.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.only(bottom: 8),
                      width: double.infinity,
                      height: 74,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        progressDropdownButton(),
                        Padding(padding: EdgeInsets.only(right: 10)),
                        addProgressButton(),
                      ],
                    )
                  ],
                ),
              )
            )
          )

        ],
      ),
    );
  }
}

Widget positionChip() => DecoratedBox(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.white
  ),
  child: Padding(
    padding: EdgeInsets.all(5),
    child: Text(
      "Backend/Server",
      style: TextStyle(fontSize: 10),
    ), // temp
  ),
);

Widget progressButton(IconData icon) => Container(
  width: 30,
  height: 30,
  decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
      color: Colors.white
  ),
  child: Icon(icon)
);

Widget progressDropdownButton() => InkWell(
  child: progressButton(Icons.expand_more),
  onTap: () {},
);

Widget addProgressButton() => InkWell(
  child: progressButton(Icons.add),
  onTap: () {},
);

