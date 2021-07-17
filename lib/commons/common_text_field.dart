import 'package:flutter/material.dart';
import 'common_icon_button.dart';

class CommonTextField extends StatefulWidget {
  final Function onTap;

  CommonTextField({@required this.onTap});

  @override
  State<StatefulWidget> createState() => _CommonTextFieldState();
}

class _CommonTextFieldState extends State<CommonTextField> {
  final _threadTextFieldController = TextEditingController();

  @override
  void dispose() {
    _threadTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
          minHeight: 36
      ),
      child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 9),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: TextField(
                    controller: _threadTextFieldController,
                    decoration: null,
                    maxLines: null,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                Row(
                  children: [
                    CommonIconButton(
                      icon: Icons.add_a_photo,
                      onPressed: null,
                    ),
                    Padding(padding: EdgeInsets.only(right: 10)),
                    CommonIconButton(
                      icon: Icons.send_outlined,
                      onPressed: () async {
                        await widget.onTap(
                          fields: {"content": _threadTextFieldController.text},
                          //files
                        ).then((successful) {
                          if (successful) {
                            _threadTextFieldController.clear();
                            FocusScope.of(context).unfocus();
                          }
                        });
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
      ),
    );
  }
}
