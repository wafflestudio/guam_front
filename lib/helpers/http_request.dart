import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

class HttpRequest {
  final String _baseUrl = Platform.isAndroid
      ? 'http://10.0.2.2:3000/api/v1/'
      : 'http://127.0.0.1:3000/api/v1/';

  Future get({@required String authority, String path, dynamic queryParams, String authToken}) async {
    try {
      final uri = Uri.http(authority, path, queryParams);
      final response = await http.get(
        uri,
        headers: {'Content-Type': "application/json", 'Authorization': authToken},
      );

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print("Error on GET request");
    }
  }

  Future post({@required String partialUrl, String authToken, dynamic body}) async {
    try {
      final response = await http.post(
          Uri.parse(_baseUrl+partialUrl),
          headers: {'Content-Type': "application/json", 'Authorization': authToken},
          body: jsonEncode(body)
      );

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print("Error on POST request");
    }
  }

  Future delete({@required String partialUrl, @required String authToken}) async {
    try {
      final response = await http.delete(
        Uri.parse(_baseUrl+partialUrl),
        headers: {'Content-Type': "application/json", 'Authorization': authToken},
      );

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print("Error on DELETE request");
    }
  }
}
