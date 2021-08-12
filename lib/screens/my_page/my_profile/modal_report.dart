import 'package:flutter/material.dart';
import '../../../commons/common_text_field.dart';

class ModalReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Material(
          child: Container(
            padding: EdgeInsets.all(10),
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Text(
                  "문의 요청하기",
                  style: TextStyle(
                    fontSize: 12,
                    color: Color.fromRGBO(129, 129, 129, 1),
                    height: 24,
                  ),
                ),
                Text(
                  "궁금하신 사항, 버그 등을 보내주세요!<br>문의주신 내용은 개발팀 메일로 전송됩니다.",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    height: 48,
                  ),
                ),
                CommonTextField(onTap: () {})
              ],
            ),
          ),
        )
      ],
    );
  }
}
