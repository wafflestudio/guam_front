// import 'package:flutter/material.dart';
// import '../../models/boards/user_progress.dart';
// import '../../commons/profile_thumbnail.dart';
//
// class Progress extends StatelessWidget {
//   final UserProgress progress;
//
//   Progress(this.progress);
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only(top: 9),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ProfileThumbnail(
//             profile: progress.user,
//             radius: 16,
//             showNickname: false,
//           ),
//           Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(left: 9),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                         progress.progress
//                     )
//                   ],
//                 ),
//               )
//           )
//         ],
//       ),
//     );
//   }
// }
