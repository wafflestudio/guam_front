import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final Function onTap;

  CommonTextField({this.onTap});

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
    return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Container(
          height: 36,
          padding: EdgeInsets.symmetric(horizontal: 6),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _threadTextFieldController,
                  decoration: null,
                  style: TextStyle(fontSize: 12),
                ),
              ),
              IconButton(
                icon: Icon(Icons.send_outlined),
                onPressed: () async {
                  await widget.onTap({"value": _threadTextFieldController.text})
                    .then((successful) {
                      if (successful) {
                        _threadTextFieldController.clear();
                        FocusScope.of(context).unfocus();
                      }
                    });
                },
              )
            ],
          ),
        )
    );
  }
}
