import 'package:flutter/material.dart';
import '../../../commons/common_text_field.dart';

class ModalReport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Material(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.all(10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(203, 203, 203, 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.notifications_outlined,
                          color: Color.fromRGBO(129, 129, 129, 1),
                          size: 16,
                        ),
                        Text(
                          "문의하기",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(129, 129, 129, 1),
                          ),
                        ),
                      ],
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    child: Text(
                      "궁금하신 사항, 버그 등을 보내주세요!\n문의주신 내용은 개발팀 메일로 전송됩니다.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  CommonTextField(
                    allowImages: false,
                    onTap: sendEmail,
                  )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}

Future<void> sendEmail({Map<String, String> fields, dynamic files}) async {
}
