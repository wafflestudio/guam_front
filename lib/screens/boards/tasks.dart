import 'package:flutter/material.dart';
import 'package:guam_front/commons/profile_thumbnail.dart';
import '../../models/boards/user_task.dart';
import 'iconTitle.dart';
import 'task.dart';

class Tasks extends StatefulWidget {
  final List<UserTask> tasks;

  Tasks(this.tasks);

  @override
  State<StatefulWidget> createState() => TasksState();
}

class TasksState extends State<Tasks> {
  int selectedUserId; // 일단 임시로 첫 번째 사람으로 set. 최종으론 내 아이디로 init. 내 작업현황이 가장 먼저 뜨게 할 것임.
  UserTask selectedUserTask;
  List<UserTask> unselectedUsers;

  @override
  void initState() {
    super.initState();
    selectUser(widget.tasks.first.user.id);
  }

  @override
  // Board Title 통한 navigation 시 TasksState 를 해당 작업실에 맞춰 reset 하기 위함.
  void didUpdateWidget(covariant Tasks oldWidget) {
    super.didUpdateWidget(oldWidget);
    selectUser(widget.tasks.first.user.id);
  }

  void selectUser(int userId) {
    setState(() {
      selectedUserId = userId;
      selectedUserTask = widget.tasks.firstWhere((e) => e.user.id == selectedUserId);
      unselectedUsers = widget.tasks.where((e) => e.user.id != selectedUserId).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          iconTitle(icon: Icons.assignment_outlined, title: "작업 현황"),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Expanded(
                    child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(85, 88, 255, 1),
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
                                profile: selectedUserTask.user,
                                radius: 12,
                                showNickname: true,
                                textColor: Colors.white,
                              ),
                              positionChip(position: selectedUserTask.state),
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
          Container(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(85, 88, 255, 0.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: [
                    //if (selectedUserTask.task != null) Task(task: selectedUserTask),
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          progressDropdownButton(),
                          Padding(padding: EdgeInsets.only(right: 10)),
                          addProgressButton(),
                        ],
                      ),
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

Widget positionChip({@required String position}) => DecoratedBox(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(15),
    color: Colors.white
  ),
  child: Padding(
    padding: EdgeInsets.all(5),
    child: Text(
      position,
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

