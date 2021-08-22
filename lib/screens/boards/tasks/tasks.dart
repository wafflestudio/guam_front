import 'package:flutter/material.dart';
import 'package:guam_front/commons/profile_thumbnail.dart';
import '../../../models/boards/user_task.dart';
import '../iconTitle.dart';
import 'task.dart';
import '../../../commons/profile_thumbnail.dart';

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
          Container(
            child: ListView.builder(
              itemBuilder: (_, idx) => Container(
                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                margin: EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  color: Color.fromRGBO(238, 238, 238, 1),
                  borderRadius: BorderRadius.circular(20)
                ),
                child: ProfileThumbnail(
                  radius: 10,
                  profile: unselectedUsers[idx].user,
                  showNickname: true,
                  textColor: Colors.black,
                  activateRedirectOnTap: false,
                  onTap: () => selectUser(unselectedUsers[idx].user.id),
                ),
              ),
              itemCount: unselectedUsers.length,
              scrollDirection: Axis.horizontal,
            ),
            constraints: BoxConstraints(maxHeight: 30),
            margin: EdgeInsets.only(bottom: 10),
          ),
          Container(
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Color.fromRGBO(85, 88, 255, 0.5),
              ),
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(85, 88, 255, 1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 7, horizontal: 15
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ProfileThumbnail(
                                profile: selectedUserTask.user,
                                radius: 12,
                                showNickname: true,
                                textColor: Colors.white,
                                activateRedirectOnTap: true,
                              ),
                              Padding(padding: EdgeInsets.only(right: 20)),
                              positionChip(position: selectedUserTask.state),
                            ],
                          ),
                        )
                    ),
                    Task(task: selectedUserTask)
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

