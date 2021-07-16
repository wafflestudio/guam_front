import 'package:flutter/material.dart';

class MyProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Text('📋 참여한 프로젝트 ',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 5),
                  child: SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      // GetX 사용 고려?
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Text(
                          "유튜브 제작하기",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(140, 140),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // <-- Radius
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 140,
                    child: ElevatedButton(
                      // GetX 사용 고려?
                      onPressed: () {},
                      child: Padding(
                        padding: EdgeInsets.only(top: 80),
                        child: Text(
                          "딥러닝 스터디",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(140, 140),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20), // <-- Radius
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
