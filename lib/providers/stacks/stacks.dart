import 'dart:convert';
import 'package:flutter/material.dart';
import '../../helpers/http_request.dart';
import '../../helpers/decode_ko.dart';
import '../../models/stack.dart' as StackModel;
import '../../mixins/toast.dart';

class Stacks extends ChangeNotifier with Toast {
  // _stacks init to empty list for avoiding errors from calling get stacks,
  // when fetchStacks() has not yet ended.
  List<StackModel.Stack> _stacks = [];

  Stacks() {
    fetchStacks();
  }

  get stacks => _stacks;

  Future<void> fetchStacks() async {
    print("fetch stacks start"); ///
    try {
      await HttpRequest().get(
        path: "/stacks"
      ).then((response) {
        if (response.statusCode == 200) {
          final jsonUtf8 = decodeKo(response);
          final List<dynamic> jsonList = json.decode(jsonUtf8);
          _stacks = jsonList.map((e) => StackModel.Stack.fromJson(e)).toList();
          print("fetch stacks done"); ///
        }
      });
    } catch (e) {
      print(e);
    }
  }
}
