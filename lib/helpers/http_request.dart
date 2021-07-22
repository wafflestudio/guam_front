import 'dart:convert';
import 'dart:io' show File, HttpHeaders;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;

class HttpRequest {
  final String baseAuthority = "15.164.72.46:8080";
  final String s3BaseAuthority = "https://guam.s3.ap-northeast-2.amazonaws.com/";

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
        headers: {'Content-Type': "application/json", HttpHeaders.authorizationHeader: authToken},
        body: jsonEncode(body),
      );

      return response;
    } catch (e) {
      print("Error on POST request: $e");
    }
  }

  Future postMultipart({String authority, String path, String authToken, Map<String, dynamic> fields, List<File> files}) async {
    try {
      final uri = Uri.http(authority ?? baseAuthority, path);

      MultipartRequest request = MultipartRequest("POST", uri);
      request.headers['Authorization'] = authToken;
      fields.entries.forEach((e) => request.fields[e.key] = e.value);
      files.forEach((e) async {
        final multipartFile = http.MultipartFile(
          "imageFiles",
          e.readAsBytes().asStream(),
          e.lengthSync(),
          filename: e.path.split("/").last,
          contentType: MediaType("image", "${p.extension(e.path)}")
        );

        request.files.add(multipartFile);
      });

      final response = await request.send();

      return response;
    } catch (e) {
      print("Error on POST Multipart request: $e");
    }
  }

  Future put({String authority, String path, String authToken, dynamic body}) async {
    try {
      final uri = Uri.http(authority ?? baseAuthority, path);

      final response = await http.put(
        uri,
        headers: {'Content-Type': "application/json", HttpHeaders.authorizationHeader: authToken},
        body: jsonEncode(body),
      );

      return response;
    } catch (e) {
      print("Error on PUT request: $e");
    }
  }

  Future delete({String authority, String path, String authToken}) async {
    try {
      final uri = Uri.http(authority ?? baseAuthority, path);
      final response = await http.delete(
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
