import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

import 'storage.dart';

String baseUrl = 'https://www.medfestcare.com:8843/';

class ApiService {
  static Future<http.Response> postData(Map data, url) async {
    var link = Uri.parse('$baseUrl$url');
    log(link.toString());
    // log(data.toString());
    var bodyEncoded = json.encode(data);

    http.Response response = await http.post(
      link,
      body: bodyEncoded,
      headers: {
        "Content-Type": "application/json",
      },
    );
    log(response.body.toString());
    return response;
  }

  static Future<http.Response> postDataToken(Map data, url) async {
    var token = await Storage.readData("token");
    var link = Uri.parse('$baseUrl$url');
    log(link.toString());
    // log(data.toString());
    var bodyEncoded = json.encode(data);

    http.Response response = await http.post(
      link,
      body: bodyEncoded,
      headers: {
        "Content-Type": "application/json",
        'Authorization': 'Bearer $token',
      },
    );
    log(response.body.toString());
    return response;
  }

  static Future<http.Response> getDataToken(url) async {
    var token = await Storage.readData("token");
    Map<String, String> headers = <String, String>{
      'Authorization': 'Bearer $token'
    };
    log(token);
    var link = Uri.parse('$baseUrl$url');
    http.Response response = await http.get(link, headers: headers);

    return response;
  }


  

  static Future<Map> getData(String url) async {
    try {
      var link = Uri.parse('$baseUrl$url');
      log(link.toString());
      http.Response response = await http.get(link);
      var jsonData = json.decode(response.body);
      return jsonData;
    } catch (e) {
      log(e.toString());
      return {};
    }
  }

  static Future<http.Response?> postDataWithToken(Map data, url) async {
    try {
      var token = await Storage.readData("token");
      Map<String, String> requestHeaders = {
        //'Content-type': 'application/json',
        'Authorization': 'Bearer $token'
      };
      var link = Uri.parse('$baseUrl$url');
      http.Response response = await http.post(link, body: jsonEncode(data), headers: requestHeaders);
      log(response.statusCode.toString());
      return response;
    } catch (e) {
      log(e.toString());
      return null;
    }
  }

  static Future<Map<String, dynamic>> getDataWithToken(url) async {
    try {
      var token = await Storage.readData("token");
      Map<String, String> headers = <String, String>{
        'Authorization': 'Bearer $token'
      };
      log(token);
      var link = Uri.parse('$baseUrl$url');
      http.Response response = await http.get(link, headers: headers);
      Map<String, dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } catch (e) {
      log("datata");
      log(e.toString());
      return {};

      // return null;
    }
  }

  static getDataWithTokenTwo(url) async {
    try {
      var token = await Storage.readData("token");
      Map<String, String> headers = <String, String>{
        'Authorization': 'Bearer $token'
      };
      log(token);
      var link = Uri.parse('$baseUrl$url');
      http.Response response = await http.get(link, headers: headers);

      if (response.statusCode == 200) {
        String jsonString = response.body;

        return jsonString;
      }
    } catch (e) {
      log(e.toString());
      return {};

      // return null;
    }
  }
}
