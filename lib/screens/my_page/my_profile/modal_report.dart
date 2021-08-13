import 'dart:io' show File;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import '../../../mixins/toast.dart';
import '../../../providers/user_auth/authenticate.dart';
import '../../../commons/common_text_field.dart';

class ModalReport extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ModalReportState();
}

class _ModalReportState extends State with Toast {
  final String _commonReportEmail = "guam.user.report@gmail.com";
  final String _commonReportEmailPassword = "guam2021!";
  final String _guamEmail = "guam@wafflestudio.com";
  bool sendingInProgress = false;

  void toggleSendingInProgress() {
    setState(() {
      sendingInProgress = !sendingInProgress;
    });
  }

  @override
  Widget build(BuildContext context) {
    final String _user = "User Id.${context.read<Authenticate>().me.id}";

    Future<void> sendEmail({Map<String, String> fields, List<File> files}) async {
      toggleSendingInProgress();

      try {
        if (fields["content"] == "" && files.isEmpty)
          throw new FormatException("빈 메일을 보낼 수 없습니다.");

        final smtpServer = gmail(_commonReportEmail, _commonReportEmailPassword);
        final message = Message()
          ..from = Address(_commonReportEmail, _user)
          ..recipients.add(_guamEmail)
          ..text = fields["content"]
          ..attachments = [
            ...files.map((file) => FileAttachment(file))
          ];

        await send(message, smtpServer).then((report) {
          showToast(success: true, msg: "메일을 보냈습니다.");
          Navigator.of(context).pop();
        });

        return true; // to CommonTextField
      } catch (e) {
        String msg;

        if (e is MailerException) msg = "메일 전송을 실패했습니다.";
        else if (e is FormatException) msg = e.message;
        showToast(success: false, msg: msg);

        return false;// to CommonTextField
      } finally {
        toggleSendingInProgress();
      }
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
                color: Color.fromRGBO(54, 54, 54, 1),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        child: Text(
                          "Ask Guam anything 🏝️",
                          style: TextStyle(
                            fontSize: 12,
                            color: Color.fromRGBO(203, 203, 203, 1),
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 10),
                      ),
                      Container(
                        child: Text(
                          "궁금하신 사항, 버그 등을 보내주세요!\n문의주신 내용은 Guam 개발팀에게 전달됩니다.",
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
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
                            color: Color.fromRGBO(203, 203, 203, 1),
                          ),
                        ),
                        margin: EdgeInsets.only(bottom: 20),
                      ),
                      CommonTextField(onTap: sendEmail)
                    ],
                  ),
                  if (sendingInProgress) CircularProgressIndicator(),
                ],
              )
            ),
          ),
        )
      ],
    );
  }
}
