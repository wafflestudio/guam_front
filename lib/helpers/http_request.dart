import 'dart:io' show HttpHeaders;
import 'package:http/http.dart' as http;

class HttpRequest {
  final String baseAuthority = "34.84.231.149:80";
  final String kakaoAuthority = "34.84.231.149:8888";

  Future get({String authority, String path, dynamic queryParams, String authToken}) async {
    try {
      final uri = Uri.http(authority ?? baseAuthority, path, queryParams);
      final response = await http.get(
        uri,
        headers: {'Content-Type': "application/json", HttpHeaders.authorizationHeader: authToken},
      );

      return response;
    } catch (e) {
      print("Error on GET request: $e");
    }
  }

  Future post({String authority, String path, String authToken, dynamic body}) async {
    try {
      final uri = Uri.http(authority ?? baseAuthority, path);

      final response = await http.post(
        uri,
        headers: {'Content-Type': "application/x-www-form-urlencoded", HttpHeaders.authorizationHeader: authToken},
        body: body,
      );

      return response;
    } catch (e) {
      print("Error on POST request: $e");
    }
  }

  Future delete({String authority, String path, String authToken}) async {
    try {
      final uri = Uri.http(authority ?? baseAuthority, path);
      final response = await http.post(
          uri,
          headers: {'Content-Type': "application/json", HttpHeaders.authorizationHeader: authToken},
      );

      if (response.statusCode == 200) {
        return response;
      }
    } catch (e) {
      print("Error on DELETE request: $e");
    }
  }
}
