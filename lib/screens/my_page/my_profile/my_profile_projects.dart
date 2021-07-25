import 'package:flutter/material.dart';

class MyProfileProjects extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var titles = ["유튜브 제작", "괌 따라하기", "와플 스튜디오 만들기"];
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
                ...titles.map(
                  (e) => Container(
                    height: 150,
                    width: 150,
                    margin: EdgeInsets.only(right: 10),
                    child: InkWell(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Positioned.fill(
                              child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  colorFilter: ColorFilter.mode(
                                      Colors.white.withOpacity(0.5),
                                      BlendMode.dstATop),
                                  // Temp code. Should use cached_network_image with errorWidget (default image) and placeholder
                                  image:
                                      // project.thumbnail != "" ? NetworkImage(project.thumbnail) :
                                      AssetImage(
                                          "assets/images/project-thumbnail-default.png"),
                                  fit: BoxFit.fill,
                                ),
                                borderRadius: BorderRadius.circular(20)),
                          )),
                          Positioned.fill(
                            child: Container(
                              padding: EdgeInsets.all(20),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                e,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
