import 'package:flutter/material.dart';

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
            color: Color.fromRGBO(151, 151, 151, 0.5),
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
                Container(
                  constraints: BoxConstraints(
                    maxHeight: 24,
                    maxWidth: 24
                  ),
                  child: IconButton(
                    icon: Icon(Icons.send_outlined),
                    padding: EdgeInsets.all(0),
                    onPressed: () async {
                      await widget.onTap({"content": _threadTextFieldController.text})
                          .then((successful) {
                        if (successful) {
                          _threadTextFieldController.clear();
                          FocusScope.of(context).unfocus();
                        }
                      });
                    },
                  ),
                )
              ],
            ),
          ),
      ),
    );
  }
}
