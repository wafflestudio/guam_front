import 'dart:convert';
import 'dart:io' show File, HttpHeaders;
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart' as p;
import 'package:dio/dio.dart';

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

  Future post({String authority, String path, String authToken, dynamic queryParams, dynamic body}) async {
    try {
      final uri = Uri.http(authority ?? baseAuthority, path, queryParams);

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

      http.MultipartRequest request = http.MultipartRequest("POST", uri);
      request.headers['Authorization'] = authToken;
      fields.entries.forEach((e) {
        if (e.key == 'command'){
          print(json.encode(fields));
          request.fields['command'] = json.encode(fields);
        }
        else{
          request.fields[e.key] = e.value;
        }
      });
      // fields.entries.forEach((e) => request.fields[e.key] = e.value);
      if (files != null)
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

  Future postMultipartDio({String authority, String path, String authToken, Map<String, dynamic> fields, List<File> files}) async {
    try {
      final uri = Uri.http(authority ?? baseAuthority, path);

      var formData;

      if (files.length <= 1) {
        print("Only 1 file attached");
        var newFileds = {
          "title": "이걸 왜 안되냐 개같은 ",
          "description": "now encoding??",
          "thumbnail": null,
          "frontHeadCnt": '1',
          "backHeadCnt": '2',
          "designHeadCnt": '3',
          "frontStackId": '1',
          "backStackId": '2',
          "designStackId": '3',
        };
        //fields["imageFiles"] = await MultipartFile.fromFile(files[0].path, filename: files[0].path);
        formData = FormData.fromMap(newFileds);
      } else {
        print("Multi files attached");
        formData = FormData.fromMap(fields);
        formData.files.addAll(files.map((e) => MapEntry("imageFiles", MultipartFile.fromFileSync(e.path, filename: e.path))));
      }

      print(uri.toString());

      var response = await Dio().post(uri.toString(), data: formData);

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
