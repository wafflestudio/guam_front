import 'package:flutter/material.dart';
import '../../../commons/common_text_field.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../../mixins/toast.dart';
import '../../../providers/user_auth/authenticate.dart';
import 'package:provider/provider.dart';

class ModalReport extends StatelessWidget with Toast {
  @override
  Widget build(BuildContext context) {
    Future<void> sendEmail({Map<String, String> fields, dynamic files}) async {
      const String userEmail = "guam.user.report@gmail.com";
      final String user = "User Id.${context.read<Authenticate>().me.id}";
      const String password = "guam2021!";
      const String guamEmail = "guam@wafflestudio.com";

      final smtpServer = gmail(userEmail, password);
      final message = Message()
        ..from = Address(userEmail, user)
        ..recipients.add(guamEmail)
        ..text = fields["content"];

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
                      "궁금하신 사항, 버그 등을 보내주세요!\n문의주신 내용은 Guam 🏝️ 메일로 전송됩니다.",
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
