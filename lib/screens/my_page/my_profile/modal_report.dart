import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../../mixins/toast.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../../../commons/common_text_field.dart';

class ModalReport extends StatelessWidget with Toast {
  @override
  Widget build(BuildContext context) {
    Future<void> sendEmail({Map<String, String> fields, List<File> files}) async {
      const String userEmail = "guam.user.report@gmail.com";
      final String user = "User Id.${context.read<Authenticate>().me.id}";
      const String password = "guam2021!";
      const String guamEmail = "guam@wafflestudio.com";

      final smtpServer = gmail(userEmail, password);
      final message = Message()
        ..from = Address(userEmail, user)
        ..recipients.add(guamEmail)
        ..text = fields["content"]
        ..attachments = [
          ...files.map((file) => FileAttachment(file))
        ];

      bool res = false;

      try {
        await send(message, smtpServer).then((report) {
          showToast(success: true, msg: "메일을 보냈습니다.");
          res = true;
          Navigator.of(context).pop();
        });
      } on MailerException catch (e) {
        showToast(success: false, msg: "메일 전송을 실패했습니다.");
      }

      return res;
    }

    return Wrap(
      children: [
        Material(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 40),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(203, 203, 203, 0.5),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      "Ask Guam anything 🏝️",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    child: Text(
                      "궁금하신 사항, 버그 등을 보내주세요!\n문의주신 내용은 Guam 메일로 전송됩니다.",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 10),
                  ),
                  Container(
                    child: Text(
                      "· '이미지 파일' 은 문제 확인 및 해결에 큰 도움이 됩니다.\n"
                          "· '메일 계정' 을 기입해 주시면 해당 메일로 회신드리겠습니다.",
                      style: TextStyle(
                        fontSize: 12,
                        color: Color.fromRGBO(129, 129, 129, 1),
                      ),
                    ),
                    margin: EdgeInsets.only(bottom: 30),
                  ),
                  CommonTextField(onTap: sendEmail)
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
